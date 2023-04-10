from datetime import timedelta
from airflow import DAG 
from airflow.operators.python import PythonOperator
from airflow.utils.dates import days_ago
from datetime import datetime
import logging as log
from bing_etl import 
