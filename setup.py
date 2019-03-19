#!/usr/bin/env python3

from setuptools import setup

setup(
  name='batch_classify',
  version='1.0',
  url='https://github.com/EightySix-Analytics/batch-classify',
  author='John Barry',
  author_email='johnfmbarry@gmail.com',
  description='Analyse transaction data to clasify sales for further analysis',
  long_description=open('DESCRIPTION.md').read(),
  packages=['batch_classify'],
  install_requires=[
    'argparse',
    'numpy',
    'pandas',
    'psycopg2-binary',
    'python-dotenv',
  ],
  test_requirements = ['pytest'],
)
