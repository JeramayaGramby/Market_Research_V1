# Importing all necessary dependencies
import streamlit as st
import pandas as pd
from datetime import datetime

now=datetime.now()
def builder(app):
    df1=pd.read_csv('{now} Twitter_Data')
    hashtag =st.text_input('Search for a hashtag here')
    submit_button = st.button('Submit')
