import json
import logging


# initialize logger
logger = logging.getLogger()
logger.setLevel(logging.INFO)

def error_handler(event, context):
    logger.info(f"request got {event}")
    
    # TODO implement
    return {
        'statusCode': 200,
        'body': json.dumps('Bro Error Found!!!')
    }
