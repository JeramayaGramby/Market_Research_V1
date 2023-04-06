from datetime import timedelta
from airflow import DAG 
from airflow.operators.python import PythonOperator
from airflow.utils.dates import days_ago
from datetime import datetime
import sys
import logging as log

# This will allow you to import functions from other files
sys.path.insert(0, 'test_environment3/social_media')