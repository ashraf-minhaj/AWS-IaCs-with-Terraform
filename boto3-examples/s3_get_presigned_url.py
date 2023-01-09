import boto3
from botocore.config import Config

key= "test/file2.mp4"

region = 'ap-southeast-1'
bucket = "bucket_name"

s3 = boto3.client('s3', region_name=region, config=Config(signature_version='s3v4'))

print (" Generating pre-signed url...")

url = s3.generate_presigned_url('put_object', Params={'Bucket':bucket,'Key':key}, ExpiresIn=3600, HttpMethod='PUT')

print(url)