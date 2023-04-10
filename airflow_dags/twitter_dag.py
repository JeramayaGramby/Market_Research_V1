from datetime import timedelta
from airflow import DAG 
from airflow.operators.python import PythonOperator
from airflow.utils.dates import days_ago
from datetime import datetime
import logging as log
import sys
from twitter_etl import twitter_data_extractor, twitter_data_validator
from twitter_etl import twitter_data_loader

# Any time a DAG runs, it needs a function to retry itself if it doesn't work
# Or if it returns an exception that can't be handled

sys.path.insert(0, 'test_environment3/social_media')

with open() as DAG:
    pass


run_extractor = PythonOperator(task_id='twitter_data_extraction',
                         python_callable=twitter_data_extractor,
                         )

run_validator = PythonOperator(task_id='twitter_data_validation',
                         python_callable=twitter_data_validator,
                         )

run_loader = PythonOperator(task_id='twitter_data_loader',
                         python_callable=twitter_data_loader,
                         )