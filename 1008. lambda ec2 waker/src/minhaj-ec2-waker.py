""" Wake up ec2 instance using lambda

 author: ashraf minhaj
 mail  : ashraf_minhaj@yahoo.com
"""

import json
import logging
import boto3

# instance ids, we have only one
INSTANCE = ['------']

# initialize logger
logger = logging.getLogger()
logger.setLevel(logging.INFO)

def ec2waker(event, context):
    logger.info(f"request got {event}")

    ec2_client = boto3.client('ec2')
    response = ec2_client.describe_instance_status(InstanceIds=INSTANCE, IncludeAllInstances=True)

    logger.info("trying to get instance status")
    try:
        status = response['InstanceStatuses'][0]['InstanceState']['Name']
        if status == 'running':
            logger.info('It is running, what more do you expect?')

        elif status == 'stopped':
            logger.info("Instance found but not running...")

            logger.info("Starting instance...")
            ec2_client.start_instances(InstanceIds=INSTANCE)
            logger.info("Start command given")
        
        else:
            logger.info("Instance stat is not running nor stopped, what's wrong?")
            logger.info(status)

    except Exception as e:
        logger.info(e)

    # TODO implement
    return {
        'statusCode': 200,
        'body': json.dumps("Don't push me that much bruhhhhh")
    }
