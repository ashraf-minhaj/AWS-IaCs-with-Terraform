""" Wake up ec2 instance using lambda

 author: ashraf minhaj
 mail  : ashraf_minhaj@yahoo.com
"""

import json
import logging
import boto3


# initialize logger
logger = logging.getLogger()
logger.setLevel(logging.INFO)

def ec2waker(event, context):
    logger.info(f"request got {event}")

    ec2_client = boto3.client('ec2')
    response = ec2_client.describe_instance_status(InstanceIds=['--------'])

    if response['InstanceStatuses'][0]['InstanceState']['Name'] == 'running':
        print('It is running')

    # TODO implement
    return {
        'statusCode': 200,
        'body': json.dumps("Don't push me that much bruhhhhh")
    }
