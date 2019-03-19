import os
import logging
from os.path import join, dirname
from dotenv import load_dotenv

def logging_level(level):
    if level == 'DEBUG':
        return logging.DEBUG
    elif level == 'INFO':
        return logging.INFO
    elif level == 'WARNING':
        return logging.WARNING
    else:
        return logging.ERROR

dotenv_path = join(dirname(__file__), '../.env')
load_dotenv(dotenv_path)

LOG_LEVEL = logging_level(os.getenv('LOG_LEVEL'))

DB_NAME = os.getenv('DB_NAME')
USERNAME = os.getenv('USERNAME')
PASSWORD = os.getenv('PASSWORD')
HOST = os.getenv('HOST')
SSL = 'require' if os.getenv('SSL') == 'true' else 'prefer'
