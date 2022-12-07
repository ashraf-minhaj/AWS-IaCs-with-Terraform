import boto3
import json

queue = f"https://sqs.ap-southeast-1.amazonaws.com/owner-id/queue-name"

def send_message():
    sqs_client = boto3.client("sqs", region_name="ap-southeast-1")

    message = {"unprocessed": "object"}
    response = sqs_client.send_message(
        QueueUrl=queue,
        MessageBody=json.dumps(message)
    )
    print(response)

print("Sending message")
send_message()
print("Done sending message")