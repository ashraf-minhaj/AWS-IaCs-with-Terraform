init `packer init .`

format for readability `packer fmt .`

validate `packer validate .`

build image `packer build aws-ubuntu.pkr.hcl`

deregister old (same name) AMI and make a new one `packer build -force aws-ubuntu.pkr.hcl`