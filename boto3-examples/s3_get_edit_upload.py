import boto3

local_path = '/path/down.txt'

s3 = boto3.client('s3', region_name='ap-southeast-1')
s3.download_file('bucket-name', 'my_file.txt', local_path)

with open(local_path, 'a') as f:
    f.write("Some more text to append")

# now upload the file
s3.upload_file(local_path, 'bucket-name', 'my_file_updated.txt')