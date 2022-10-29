
# import json
# import logging
# import boto3
# from boto3.dynamodb.conditions import Key

# table_name = 'data3'

# partition_key = "date"
# value = "12-12-12"

# # initialize logger
# logger = logging.getLogger()
# logger.setLevel(logging.INFO)

# logger.info("Init boto client for dynamodb")
# # client = boto3.client('dynamodb')
# db = boto3.resource('dynamodb')

# # # connecting with table
# table = db.Table(table_name)

# def query_handler(event, context):
#     logger.info(f"request got {event}")

#     # scan gets all data
#     # data = table.scan()
#     # logger.info(f"data, type {type(data)}: {data}")

#     logger.info(f"Performing Query for {partition_key} with {value}")

#     response = table.query(
#     KeyConditionExpression=Key(partition_key).eq(value)
#     )

#     logger.info(f"data type: {type(response)}, response data: {response}")


#     # TO DO implement
#     return {
#         'statusCode': 200,
#         'body': json.dumps('Khatam Sir!!!!!')
#     }


import json
import logging
import boto3
from boto3.dynamodb.conditions import Key

table_name = 'db5'

partition_key = "date"
partition_key_val = "10-10-10"
sort_key = "shows"

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

    # scan gets all data
    # data = table.scan()
    # logger.info(f"data, type {type(data)}: {data}")

    logger.info(f"Performing Query for {partition_key} with {partition_key_val}")

    response = table.query(
    KeyConditionExpression=Key(partition_key).eq(partition_key_val),
    ProjectionExpression = sort_key)


    logger.info(f"data type: {type(response)}, response data: {response}")

    return {
        'statusCode': 200,
        'body': json.dumps('Khatam Sir!!!!!')
    }
