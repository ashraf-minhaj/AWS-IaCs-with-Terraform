#!/bin/bash

######################################################
# author: ashraf minhaj
# mail : ashraf_minhaj@yahoo.com
#
# logs into aws ecr repo, builds and tags docker image
######################################################

VERSION_TAG=$1

cd ../app

docker build -t test:$VERSION_TAG .

# docker <Option> <your-account-id>.dkr.ecr.<your-region>.amazonaws.com/<your-repository-name>:<tag>
aws ecr get-login-password --region ap-southeast-1 | docker login --username AWS --password-stdin 669201380121.dkr.ecr.ap-southeast-1.amazonaws.com

docker tag test:$VERSION_TAG 669201380121.dkr.ecr.ap-southeast-1.amazonaws.com/repository-test:$VERSION_TAG

docker push 669201380121.dkr.ecr.ap-southeast-1.amazonaws.com/repository-test:$VERSION_TAG
