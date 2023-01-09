import boto3

launchTemplateId = 'lt-00000'

ec2 = boto3.client('ec2', region_name='ap-southeast-1')

template_specifics = {
    'LaunchTemplateId': launchTemplateId
}

resp = ec2.run_instances(
    MaxCount=1, 
    MinCount=1,
    LaunchTemplate=template_specifics,
    ImageId='ami-00000'
    )

print(resp['ResponseMetadata']['HTTPStatusCode'])