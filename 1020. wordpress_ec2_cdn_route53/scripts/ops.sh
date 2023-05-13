#!/bin/sh

# arguments should be - init, plan, apply, destroy
echo "arg: $1"

cd ../Terraform
ls -a

if [[ "$1" == "init" ]];
then
    echo "Initializing..."
    terraform $1 -input=false -backend-config=backend.conf -var-file=terraform.tfvars -lock=true
    exit
fi 

if [[ "$1" == "apply" || "$1" == "destroy" ]]; 
    then
        echo "operation: $1"
         terraform $1 -var-file=terraform.tfvars -auto-approve
    else
        echo "Wrong Argument"
        echo "Pass 'init', 'destroy or 'apply' only."
fi 