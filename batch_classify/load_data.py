import os
import sys
import logging
import psycopg2
import pandas as pd
from batch_classify import settings

logger = logging.getLogger(__name__)

def from_csv_file(filepath):
    dataframe=pd.read_csv(
        filepath,
        encoding='utf-8',
        header=0,
        index_col=0,
        parse_dates=['delivered','last_delivered','modified']
    )
    if 'delivered' in dataframe.columns:
        dataframe['delivered']=dataframe['delivered'].dt.date
    if 'last_delivered' in dataframe.columns:
        dataframe['last_delivered']=dataframe['last_delivered'].dt.date
    logger.debug('Read input csv file, {0}'.format(filepath))
    return dataframe

def get_supplier_id(conn, supplier):
    with conn.cursor() as cursor:
        query = "SELECT id FROM suppliers WHERE code = %(supplier)s"
        cursor.execute(query, vars={'supplier': supplier})
        return cursor.fetchone()[0]

def load_customer_products(conn, supplier_id, start_date, end_date):
    query = "SELECT " \
            "customer_id, " \
            "product_id, " \
            "last_delivered::DATE AS last_delivered, " \
            "outlier, " \
            "active " \
        "FROM customer_products " \
        "WHERE (customer_id, product_id) IN (" \
            "SELECT " \
                "customer_id, product_id " \
            "FROM transactions " \
            "JOIN customers ON transactions.customer_id=customers.id " \
            "WHERE customers.supplier_id = %(supplier_id)s " \
                "AND delivered::DATE BETWEEN %(start_date)s AND %(end_date)s " \
        ")"

    customer_products = pd.read_sql(
        query, conn, parse_dates=['last_delivered'],
        params={'supplier_id': supplier_id, 'start_date': start_date.date(), 'end_date': end_date.date()},
    )
    logger.info('Loaded %s customer_products for classification', customer_products.shape[0])
    if customer_products.empty:
        logger.info('No customer_products found for transaction dates {0} to {1}'.format(start_date.date(), end_date.date()))
    return customer_products

def load_transactions(conn, supplier_id, start_date, end_date):
    query = "SELECT " \
            "customer_id, " \
            "product_id, " \
            "delivered::DATE AS delivered, " \
            "quantity, " \
            "price, " \
            "status " \
        "FROM transactions " \
        "JOIN customers ON customers.id=transactions.customer_id " \
        "WHERE customers.supplier_id = %(supplier_id)s " \
            "AND delivered::DATE BETWEEN %(start_date)s AND %(end_date)s "

    transactions = pd.read_sql(
        query, conn, parse_dates=['delivered'],
        params={'supplier_id': supplier_id, 'start_date': start_date.date(), 'end_date': end_date.date()},
    )
    logger.info('Loaded %s transactions for classification', transactions.shape[0])
    if transactions.empty:
        raise ValueError('No transactions found between {0} and {1}'.format(start_date.date(), end_date.date()))
    else:
        return transactions

def from_database(supplier, start_date, end_date):
    with psycopg2.connect(
        dbname = settings.DB_NAME,
        user = settings.USERNAME,
        password = settings.PASSWORD,
        host = settings.HOST,
        sslmode = settings.SSL,
    ) as conn:
        supplier_id = get_supplier_id(conn, supplier)
        transactions = load_transactions(conn, supplier_id, start_date, end_date)
        customer_products = load_customer_products(conn, supplier_id, start_date, end_date)
        return transactions, customer_products
