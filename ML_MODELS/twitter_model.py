import logging as log
from datetime import datetime
from numba import jit
# Remember that Rob Mulla video about Sentiment Analysis
# You can use hugging face's Roberta model to perform sentiment analysis
# For other ML models, use hugging face
# Remember that models have to be trained before they can be used
# Hugging Face provides really good training data
# The code for all the ML model stuff might have to be placed in another EC2
# Transformer based ML Models like Roberta accounts for the context
# This makes Transformers models way more accurate