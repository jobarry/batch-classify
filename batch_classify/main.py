import logging
from batch_classify import load_data, classify, save_data
from datetime import datetime, timedelta

logger = logging.getLogger(__name__)

def run(supplier, analysed_date, included_previous=1):
    end_date = analysed_date
    start_date = end_date - timedelta(days=included_previous)

    logger.info('Analysing transactions in relation to those occuring between %s and %s', start_date.date(), end_date.date())
    
    transactions, customer_products = load_data.from_database(supplier, start_date, end_date)
    classified = classify.transactions(transactions, customer_products)
    save_data.update_database(classified)
