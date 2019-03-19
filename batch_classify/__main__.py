import os
import sys
import argparse
import logging
from datetime import datetime

logger = logging.getLogger(__name__)

def valid_date(date_str):
    try:
        return datetime.strptime(date_str, '%Y%m%d')
    except ValueError:
        msg = "Not a valid date format: '{0}'. Must be YYYYMMDD".format(date_str)
        raise argparse.ArgumentTypeError(msg)

def parse_args(args):
  parser = argparse.ArgumentParser()
  parser.add_argument(
    '-s', '--supplier',
    required=True,
    dest='supplier',
    type=str,
    help="The supplier code for which sales data will be classified."
  )
  parser.add_argument(
    '-d', '--date', '--transaction_date',
    required=True,
    dest='transaction_date',
    type=valid_date,
    help="Classification will be carried out on transactions which have occured on this date. Must be in YYYYMMDD format."
  )
  parser.add_argument(
    '-p', '--prev', '--previous',
    required=False,
    dest='days_previous',
    default=1,
    type=int,
    help="Additional transactons occuring this many days before the specified date will also be classified."
  )
  if len(args)==0:
    parser.print_help()
    sys.exit(1)
  return parser.parse_args(args)

if __name__ == '__main__':
    sys.path.insert(0, os.path.abspath(os.path.join(os.path.dirname(__file__), '..')))
    from batch_classify import settings, run

    logging.basicConfig(format='%(name)s:%(levelname)s - %(message)s', level=settings.LOG_LEVEL)

    args = parse_args(sys.argv[1:])
    run(args.supplier, args.transaction_date, args.days_previous)
