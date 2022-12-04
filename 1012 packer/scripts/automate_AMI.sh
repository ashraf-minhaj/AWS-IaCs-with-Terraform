#!/bin/bash
cd ../
packer init .
packer fmt .
packer validate .
packer build -force aws-ubuntu.pkr.hcl
sleep 5
terraform plan
terraform apply -auto-approve