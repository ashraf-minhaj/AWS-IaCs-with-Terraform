"""
 author : ashraf minhaj
 mail   : ashraf_minhaj@yahoo.com

 date: 25-11-2023
 simple flask app
"""

from flask import Flask

PORT = 80

# Flask constructor takes module (__name__) as argument.
app = Flask(__name__)

@app.route('/')
def hello_world():
	print("new request came by") # to check logs only
	return 'Hey man, this is working on your machine too, and I am running from ECR Fargate, cool!'

# main driver function
if __name__ == '__main__':
	app.run(debug=False, port=PORT, host="0.0.0.0")