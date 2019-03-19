import os
import sys
import logging
import psycopg2
from io import BytesIO
from batch_classify import settings

logger = logging.getLogger(__name__)

def to_csv_file(dataframe, filename='transaction_status.csv'):
    ordered_cols = ['customer_id','product_id','delivered','cost','price','quantity','status']
    dataframe = dataframe[ordered_cols]
    dataframe.to_csv(
        filename,
        index=False,
        encoding='utf-8'
    )

def to_csv_object(dataframe):
    ordered_cols = ['customer_id','product_id','delivered','cost','price','quantity','status']
    dataframe = dataframe[ordered_cols]
    csv_string = dataframe.to_csv(
        index=False,
        encoding='utf-8'
    )
    csv_obj = BytesIO(
        bytearray(csv_string, 'utf-8')
    )
    return csv_obj

def load_tmp_table(conn, csv_obj):
    with conn.cursor() as cursor:
        create_tmp_table = "" \
            "CREATE TEMP TABLE source(" \
                "customer_id INT," \
                "product_id INT," \
                "delivered TIMESTAMP," \
                "cost DECIMAL(10,2)," \
                "price DECIMAL(10,2)," \
                "quantity FLOAT," \
                "status VARCHAR(255)," \
                "modified TIMESTAMP DEFAULT NOW())"
        cursor.execute(create_tmp_table)
        cursor.copy_expert("COPY source(customer_id,product_id,delivered,cost,price,quantity,status) FROM STDIN DELIMITER ',' ESCAPE '$' CSV HEADER", csv_obj)
        if logger.getEffectiveLevel() < 30:
            cursor.execute('SELECT COUNT(*) FROM source')
            logger.info('Read %s rows into source temporary table', cursor.fetchone()[0])

def update_customer_products(conn):
    """
    This query needs to be updated and tested to ensure database entries are only updated based on the
    last occuring tranaction status.
    """
    with conn.cursor() as cursor:
        # upsert_customer_products = "" \
        #     "UPDATE customer_products " \
        #         "SET " \
        #             "customer_products.active = FALSE, " \
        #             "customer_products.modified = NOW() " \
        #     "FROM source " \
        #     "WHERE customer_products.customer_id = source.customer_id " \
        #         "AND customer_products.product_id = source.product_id " \
        #         "AND source.status = 'lost'"
        # cursor.execute(upsert_transactions)
        logger.info('%s rows affected within the transactions table', cursor.rowcount)

def update_transactions(conn):
    with conn.cursor() as cursor:
        # upsert_transactions = "" \
        #     "UPDATE transactions " \
        #         "SET " \
        #             "transactions.status = source.status, " \
        #             "transactions.modified = NOW() " \
        #     "FROM source " \
        #     "WHERE transactions.customer_id = source.customer_id " \
        #         "AND transactions.product_id = source.product_id " \
        #         "AND transactions.delivered = source.delivered"
        # cursor.execute(upsert_transactions)
        logger.info('%s rows affected within the transactions table', cursor.rowcount)

def update_database(transactions):
    with psycopg2.connect(
        dbname = settings.DB_NAME,
        user = settings.USERNAME,
        password = settings.PASSWORD,
        host = settings.HOST,
        sslmode = settings.SSL,
    ) as conn:
        csv_obj = to_csv_object(transactions)
        load_tmp_table(conn, csv_obj)
        update_transactions(conn)
        update_customer_products(conn)
