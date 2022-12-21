#!/bin/bash
cd ../
packer init .
packer fmt .
# packer validate .
packer validate -var-file="pkrvars.hcl" .
# packer build -force aws-ubuntu.pkr.hcl
packer build -force -var-file="pkrvars.hcl" .
sleep 5
terraform plan
terraform apply -auto-approve