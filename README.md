# IaCs with Terraform
 Testing and learning Terraform Infrastructure As Code with AWS services

![](https://img.shields.io/badge/Terraform-Version%201.3.3-white?style=plastic&logo=terraform)&nbsp; 
![](https://img.shields.io/badge/Python-Version%203.10-yellow?style=plastic&logo=python)&nbsp;
![](https://img.shields.io/badge/Packer-Version%20%3E=%200.0.2-blue?style=plastic&logo=packer)&nbsp;

#### Making aws infrastructures with Terraform:
* create s3 bucket  (tested)
* python file -> zip -> up to s3 -> create a lambda function (tested)
* AWS API Gateway Rest API with Lambda (tested)
* Dynamodb scan, perform query using Python Lambda (tested)
* Dynamodb PutItem using Python Lambda (tested)
* Dynamodb data manipulation with Python
* lambda create ec2 instance
* lambda start ec2 instance
* ec2 provision local files
* read, delete sqs message
* step function with lambda
* (NEXT) __Project:__ BackBencher Replies API (API Gateway, Lambda, Dynamodb)
* (NEXT) EC2
* (NEXT) API Gatway -> SNS -> Lambda
* (NEXT) Fully functional Serverless Application 
* Packer - done
#### Projects
* Idiot API: a serverless application that returns random illogical responses to irritate you.
Tech: APIGW, Lambda, S3, CloudWatch, Python3


and so on....
This is an incremental process of making things from the beginning. Learn while making!
The codes are tested by me. But I can not assure that they will run on your world/devices.

To run -

`$ terraform init`

`$ terraform plan`

`$ terraform apply`

If you wish to delete infrastructures after playing:
 
`$ terraform destroy`

##### Ashraf Minhaj
##### Find me on LinkedIn [Ashraf-Minhaj](https://www.linkedin.com/in/ashraf-minhaj/)
