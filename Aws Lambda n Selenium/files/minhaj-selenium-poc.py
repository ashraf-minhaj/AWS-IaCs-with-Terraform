import json
from lib2to3.pgen2 import driver
import logging
from selenium import webdriver
from selenium.webdriver.chrome.options import Options
from selenium.webdriver.chrome.service import Service
from webdriver_manager.chrome import ChromeDriverManager
import requests

# initialize logger
logger = logging.getLogger()
logger.setLevel(logging.INFO)

# setup driver
logger.info("Setting up options for driver")
chrome_options = Options()
chrome_options.add_argument('--no-sandbox')
# chrome_options.add_argument
driver = webdriver.Chrome(service=Service(ChromeDriverManager().install()), options=chrome_options)


    
def query_handler(event, context):
    logger.info(f"request got {event}")
    
    # TODO implement
    return {
        'statusCode': 200,
        'body': json.dumps('No error, Its a success boss!!!!!!!')
    }
