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

TWITTER_ACCESS_TOKEN=config('TWITTER_ACCESS_TOKEN')

auth = tweepy.OAuthHandler(access_token=TWITTER_ACCESS_TOKEN)