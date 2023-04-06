# Importing all necessary dependencies
import logging as log
from datetime import datetime
import os
from numba import jit
import logging as log
import geopy

now=datetime.now()
log.basicConfig(level=log.INFO, filename=f'{now} facebook_etl_log.csv', filemode='w', 
                format='%(asctime)s - %(levelname)s - %(message)s')