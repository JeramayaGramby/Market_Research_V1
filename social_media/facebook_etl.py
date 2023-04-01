# Importing all necessary dependencies
import logging as log
from datetime import datetime

today=datetime.today()
log.basicConfig(level=log.INFO, filename=f'{today} facebook_etl_log.csv', filemode='w', 
                format='%(asctime)s - %(levelname)s - %(message)s')