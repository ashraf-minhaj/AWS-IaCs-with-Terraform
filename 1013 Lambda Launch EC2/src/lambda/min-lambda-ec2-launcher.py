"""
 Launch ec2 instance from lambda

 author: ashraf minhaj
 mail  : ashraf_minhaj@yahoo
"""

import os
import boto3


# env specific vars
AMI             = os.environ['img_id']
PROFILE         = os.environ['profile']
ENV             = os.environ['env']
INSTANCE_TYPE   = os.environ['instance_type']
SECURITY_GROUP  = os.environ['sg']
KEY_NAME        = os.environ['key']
INSTANCE_NAME   = os.environ['instance_name']
REGION          = os.environ['region']
# print('Env Specifics:' + ' ' + ENV + ' '  + REGION + ' '  + QUEUE + ' ' + AMI + ' ' + PROFILE + ' ' + INSTANCE_TYPE + ' ' + SECURITY_GROUP + ' ' + KEY_NAME + ' ' + INSTANCE_NAME)


def create_instance():
    """ launch ec2 instance. """
    ec2 = boto3.client('ec2', region_name=REGION)
    
    init_script = f'''#!/bin/bash
    echo "run something on your instance"
    '''

    # logger.info(init_script)
    instance = ec2.run_instances(
        ImageId=AMI,
        InstanceType=INSTANCE_TYPE,
        KeyName=KEY_NAME,
        MaxCount=1,
        MinCount=1,
        UserData=init_script,
        InstanceInitiatedShutdownBehavior='terminate', 
        IamInstanceProfile={
          'Name': PROFILE
          },
        TagSpecifications=[{
            'ResourceType': 'instance',
            'Tags': [{
                    'Key': 'Name',
                    'Value': INSTANCE_NAME
                    },
                ]
            }
        ]
    )
    
    # logger.info("New instance created:")
    instance_id = instance['Instances'][0]['InstanceId']
    # logger.info(instance_id)

    return instance['ResponseMetadata']['HTTPStatusCode']



def launcher_handler(event, context):
    """ check mime, on success dump message in sqs. """
    # logger.info(event)
    # print(type(event))
    instance_create_resp = create_instance()
    if instance_create_resp == 200:
        print("Job Successful")
    else:
        print("Instance creation went wrong")