import json
import logging


# initialize logger
logger = logging.getLogger()
logger.setLevel(logging.INFO)

def func2_handler(event, context):
    logger.info(f"request got {event}")
    
    # TODO implement
    return {
        'statusCode': 200,
        'body': json.dumps('lambda 2')
    }
