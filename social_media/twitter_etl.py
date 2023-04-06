import os
from numba import jit
import logging as log
import geopy
import tweepy 
import pandas as pd
import json
from datetime import datetime
import boto3
from decouple import config
from airflow import DAG

TWITTER_ACCESS_TOKEN=config('TWITTER_ACCESS_TOKEN')
TWITTER_CONSUMER_ACCESS_KEY=config('TWITTER_CONSUMER_ACCESS_KEY')

@jit
def twitter_data_extractor(latitude,longitude):
    # Twitter Authentication
    auth = tweepy.OAuthHandler(access_token=TWITTER_ACCESS_TOKEN)
    auth.set_access_token()
    api = tweepy.API(auth)


    tweets = api.available_trends()
    global_twitter_trends = api.reverse_geocode(latitude,longitude)

    with open('api_responses/output.json', 'w') as api_output_file:
            json.dump(global_twitter_trends,api_output_file,sort_keys=True)
        
        with open('api_responses/output.json', 'r', encoding='utf-8') as api_output_file:
            imported_output_file = json.loads(api_output_file.read())
    
    # Create a list of geopy.Point points
    # Iterate over all points in range of the numbers needed
    # Append the list of those numbers to an empty list
    # The list never needs to change once it is created
