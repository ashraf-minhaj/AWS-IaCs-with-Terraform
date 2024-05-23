# IACs with Terraform
 Diffrente AWS Infrastructure resources written with Terraform.

-----------

<div align="center">

![](https://img.shields.io/badge/Terraform-Version%201.3.3-white?style=plastic&logo=terraform)&nbsp; 
![](https://img.shields.io/badge/Python-Version%203.10-yellow?style=plastic&logo=python)&nbsp;
![](https://img.shields.io/badge/Packer-Version%20%3E=%200.0.2-blue?style=plastic&logo=packer)&nbsp;

</div>

----------

# List Of Infrastructures Making aws infrastructures with Terraform:
 * create s3 bucket
 * create a lambda function (source code -> zip -> up to s3 -> lambda)
 * AWS API Gateway Rest API with Lambda
 * Dynamodb scan, perform query using Python Lambda 
 * Dynamodb PutItem using Python Lambda 
 * Dynamodb data manipulation with Python
 * lambda create ec2 instance 
 * lambda start ec2 instance
 * ec2 provision local files
 * read, delete sqs message
 * step function with lambda
 * Packer - create AMI
 * lambda launch ec2
 * step function state machine with lambdas
 * s3 and event-bridge
 * terraform read environment variables
 * Classic Load Balancer with Autoscale
 * Application Load Balancer
 * Terraform and docker ec2
 * ECR ECS DOCKER FARGATE
 * Provision and Run Docker Compose on ec2
 * VPC with NAT Gateway and eIP

<!-- #### May be next (just... may be)
 * (NEXT) __Project:__ BackBencher Replies API (API Gateway, Lambda, Dynamodb)
 * (NEXT) EC2
 * (NEXT) API Gatway -> SNS -> Lambda
 * (NEXT) Fully functional Serverless Application -->

<!-- #### Projects
 * AWS autoscale and load balancing with route53 (clb and alb)
 * Idiot API: a serverless application that returns random illogical responses to irritate you.
Tech: APIGW, Lambda, S3, CloudWatch, Python3 -->


and so on....
This is an incremental process of making things from the beginning. Learn while making!
The codes are tested by me. But I can not assure that they will run on your world/devices. I wish we lived in a perfect world!

To run -

 `$ terraform init`

 `$ terraform plan`

 `$ terraform apply`

If you wish to delete infrastructures after playing:
 
 `$ terraform destroy`

##### Ashraf Minhaj
##### Find me on LinkedIn [Ashraf-Minhaj](https://www.linkedin.com/in/ashraf-minhaj/)
