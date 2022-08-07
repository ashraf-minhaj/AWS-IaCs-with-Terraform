""" Send random illogical responses just like a idiot guy

 author: Ashraf Minhaj
 mail  : ashraf_minhaj@yahoo.com

Last coded: Aug 8 2022
"""

import json
import logging
import random


texts = [
    "It was a stupid request, of course.",
    "After Tuesday, even the calendar says WTF. Anyway, what did you request for?",
    "My tallest finger loves giving people standing ovations. That's the response bro!",
    "Don't ping me man, get a job!"
]

# initialize logger
logger = logging.getLogger()
logger.setLevel(logging.INFO)

def query_handler(event, context):
    logger.info(f"request got {event}")
    
    response_text = random.choice(texts)
    logger.info(f"returning- {response_text}")

    return {
        'statusCode': 200,
        'body': json.dumps(response_text)
    }
