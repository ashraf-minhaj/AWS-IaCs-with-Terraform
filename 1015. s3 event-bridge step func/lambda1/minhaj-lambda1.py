import json
import logging


# initialize logger
logger = logging.getLogger()
logger.setLevel(logging.INFO)

def func1_handler(event, context):
    logger.info(f"request got {event}")
    try:
        print('shei')

    except Exception as e:
        raise e
    
    # TODO implement
    return {
        'statusCode': 403,
        'body': json.dumps('this is lambda 1')
    }
