
import json
import logging
import boto3

table_name = 'data3'

# initialize logger
logger = logging.getLogger()
logger.setLevel(logging.INFO)

logger.info("Init boto client for dynamodb")
# client = boto3.client('dynamodb')
db = boto3.resource('dynamodb')

# # connecting with table
table = db.Table(table_name)

def query_handler(event, context):
    logger.info(f"request got {event}")

    data = table.scan()
    logger.info(f"data, type {type(data)}: {data}")

    # TODO implement
    return {
        'statusCode': 200,
        'body': json.dumps('Khatam Sir!!!!!')
    }
