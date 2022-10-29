""" Put an iteam in dynamodb table

reference: https://stackoverflow.com/questions/47466671/how-to-create-and-insert-json-into-amazon-web-services-dynamo-db-in-lambda-funct

 For future reference -
 To update:
 * read db table
 * check if items Partition Key is available
    * check if the key value exists
    * append to data
    * update_item
 * else put_item

 author: ashraf minhaj
 mail  : ashraf_minhaj@yahoo.com
"""

import json
import logging
import boto3

table_name = "data3"
result = "Did not run sccuessfully, you are a disgrace!!"

# item data to write
data = {
    "date": "13-13-13",
    "show":
        {
            "Iron Man":
            {
                "12:30": 
                {
                    "hall": 1
                },
                "16:30": 
                {
                    "hall": 2
                }
            }  
        }
    }


# initialize logger
logger = logging.getLogger()
logger.setLevel(logging.INFO)

logger.info("Init boto client and connecting with table")
db_table = boto3.resource('dynamodb').Table(table_name)  # connecting with table
logger.info("Connection with table: Success")
logger.info(f"Table status {db_table.table_status}")

def query_handler(event, context):
    logger.info(f"Event= {event} \n Event dtype {type(event)}")

    # basic put item
    res = db_table.put_item(Item=data)
    if res["ResponseMetadata"]["HTTPStatusCode"] == 200 :
        result = "Put item Success"
    else:
        result = "Put item failed"

    return {
        'statusCode': 200,
        'body': json.dumps(result)
    }
