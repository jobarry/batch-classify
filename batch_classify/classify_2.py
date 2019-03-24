import pandas as pd
import numpy as np
import datetime

#data import
transactions = pd.read_csv("transactions.csv")
cust_products = pd.read_csv("customer_products.csv")
today = datetime.date.today()

#convert dates and merge datasets
transactions['delivered'] = pd.to_datetime(transactions['delivered']).dt.date
cust_products['last_delivered'] = pd.to_datetime(cust_products['last_delivered']).dt.date
structured_transactions=transactions.sort_values(['customer_id','product_id','delivered'],ascending=True)
structured_transactions=structured_transactions.merge(cust_products[['customer_id','product_id','outlier']], left_on=['customer_id','product_id'], right_on=['customer_id','product_id'], how='left')

#group by and shift to align delivery dates to prior delivery dates and get the time gap
grouped=structured_transactions.groupby(['customer_id','product_id','delivered'])['outlier','delivered','cost','price','quantity'].last()
grouped['last_delivered'] = grouped.groupby([grouped.index.get_level_values('customer_id'),'product_id'])['delivered'].shift()
grouped['last_delivered']=grouped['last_delivered'].fillna(grouped['delivered'])
grouped['gap']=(grouped['delivered'] - grouped['last_delivered']).dt.days

#calculate order status
def calculate_transaction_status(gap, outlier):
    if gap==0:
        return "new"
    if gap>outlier*2:
        return "lost"
    elif gap>outlier:
        return "opportunity"
    elif gap<outlier:
        return "return"

grouped['status'] = np.vectorize(calculate_transaction_status)(grouped['gap'], grouped['outlier'])

#need last row of each product group to compare against today
def calculate_last_transaction(lr):
    if lr[0] + datetime.timedelta(lr[1]*2)<today and lr[0]!=lr[0]:
        return 'lost'
    elif lr[0] + datetime.timedelta(lr[1])<today and lr[0]!=lr[0]:
        return 'opportunity'
    else:
        return lr[2]

grouped.loc[grouped.groupby(['customer_id','product_id'])['delivered'].tail(1).index, 'status'] = grouped[['delivered','outlier','status']].apply(calculate_last_transaction, axis=1)
grouped.to_csv('transactions_status.csv', sep=',', encoding='utf-8',index=True)
