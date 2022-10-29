import queue
import boto3

# queue = "https://sqs.---.amazonaws.com/---/test-queue.fifo" # fifo
queue = "https://sqs.--_.amazonaws.com/---/test-std"         # standard


def process_message():
    sqs_client = boto3.client("sqs")
    response = sqs_client.receive_message(
        QueueUrl=queue,
        MaxNumberOfMessages=1,
        WaitTimeSeconds=15,
    )
    # print(response)
    # print(response)

    print(f"Number of messages received: {len(response.get('Messages', []))}")

    message = response.get("Messages", [])[0]
    # print(message)
    message_body = message["Body"]
    receipt_handle = message['ReceiptHandle']
    print(f"Message body: {message_body}")
    print(f"Receipt Handle: {receipt_handle}")

    # trying to delete the message
    dlt_response = sqs_client.delete_message(
        QueueUrl=queue,
        ReceiptHandle=receipt_handle
        )

    print("Deleted? ", message_body)
    print(dlt_response['ResponseMetadata']['HTTPStatusCode'])

process_message()