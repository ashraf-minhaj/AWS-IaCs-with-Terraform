import json
import logging


# initialize logger
logger = logging.getLogger()
logger.setLevel(logging.INFO)

def query_handler(event, context):
    logger.info(f"request got {event}")
    
    # TODO implement
    return {
        'statusCode': 200,
        'body': json.dumps('Sorry sir, My dog ate my Home Work. So, it is a 404 but not a 404.')
    }
