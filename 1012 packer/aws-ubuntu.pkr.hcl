# HCL2 - transcoder_image.pkr.hcl
variable "ami_name" {

}

variable "aws_region" {

}

variable "image_owners" {

}

packer {
  required_plugins {
    amazon = {
      version = ">= 1.1.6"
      source  = "github.com/hashicorp/amazon"
    }
  }
}

source "amazon-ebs" "ubuntu" {
  ami_name      = "${var.ami_name}"
  instance_type = "t2.micro"
  region        = "${var.aws_region}"
  source_ami_filter {
    filters = {
      name                = "ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"
      root-device-type    = "ebs"
      virtualization-type = "hvm"
    }
    most_recent = true
    owners      = "${var.image_owners}"
  }
  ssh_username = "ubuntu"
}

build {
  name = "build-image"
  sources = [
    "source.amazon-ebs.ubuntu"
  ]

  provisioner "shell" {
    environment_vars = [
      "VARIABLE_=This is to visualize completion",
    ]
    inline = [
      "echo Installing dependencies",
      "sleep 30",
      "sudo apt update && sudo apt upgrade -y",
      // "sudo apt-get install ffmpeg -y",
      "sudo apt install awscli -y",
      // "sudo apt-get install python3.10 -y"
      "sudo apt install python3-pip -y",
      "sudo mkdir project",
      "sudo mkdir project/src",
      "echo \"Fact is $VARIABLE_\" > done.txt",
    ]
  }

  provisioner "file" {
    source      = "src/main.py"
    destination = "/tmp/main.py"
  }

  provisioner "shell" {
    inline = ["sudo mv /tmp/main.py /home/ubuntu/project/src/main.py"]
  }

  provisioner "shell" {
    inline = [
      "sudo pip3 install boto3",
      "sudo pip3 install ec2-metadata",
      ]
  }
}
