import boto3

MAX_MESSAGE     = 1
WAIT_INTERVAL   = 15

queue = f"https://sqs.ap-southeast-1.amazonaws.com/owner-id/queue-name"
sqs_client = boto3.client("sqs", region_name="ap-southeast-1")

response = sqs_client.receive_message(
        QueueUrl=queue,
        MaxNumberOfMessages=MAX_MESSAGE,
        WaitTimeSeconds=WAIT_INTERVAL,
        )

response_content = response.get('Messages', [])
# num_of_msgs = len(response_content)
print(response_content)
print(type(response_content))
# body has the actual content
if response_content:
    message_body = response_content[0]['Body']
    print(message_body)
elif not response_content:
    print("No message")
