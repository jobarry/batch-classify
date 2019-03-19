import os
import sys
import logging
import pandas as pd
from datetime import datetime

def transactions(transactions, customer_products):
    columns = ['customer_id','product_id','delivered','cost','price','quantity','status']
    return pd.DataFrame(columns=columns)

if __name__ == '__main__':
    sys.path.insert(0, os.path.abspath(os.path.join(os.path.dirname(__file__), '..')))
    from batch_classify import load_data, save_data
    transactions = load_data.from_csv_file('transactions.csv')
    customer_products = load_data.from_csv_file('customer_products.csv')
    classified = transactions(transactions, customer_products)
    save_data.to_csv_file('transaction_status.csv')
