# HCL2
packer {
  required_plugins {
    amazon = {
      version = ">= 0.0.2"
      source  = "github.com/hashicorp/amazon"
    }
  }
}

source "amazon-ebs" "ubuntu" {
  ami_name      = "learn-packer-linux-aws"
  instance_type = "t2.micro"
  region        = "ap-southeast-1"
  source_ami_filter {
    filters = {
      name                = "ubuntu/images/*ubuntu-xenial-16.04-amd64-server-*"
      root-device-type    = "ebs"
      virtualization-type = "hvm"
    }
    most_recent = true
    owners      = ["099720109477"]
  }
  ssh_username = "ubuntu"
  // ssh_username = "root"
}

build {
  name = "learn-packer"
  sources = [
    "source.amazon-ebs.ubuntu"
  ]

  provisioner "shell" {
    environment_vars = [
      "VARIABLE_FACT=Ashraf Minhaj M!nhaj is awsome",
    ]
    inline = [
      "echo Installing dependencies",
      "sleep 30",
      "echo \"Fact is $VARIABLE_FACT\" > example.txt",
      "sudo apt update && sudo apt upgrade -y",
      "sudo apt-get install ffmpeg -y",
      "sudo apt install awscli -y",
      "sudo apt install python3-pip -y",

      "sudo wget https://github.com/shaka-project/shaka-packager/releases/download/v2.6.1/packager-linux-x64  -O ../../bin/packager",
      "sudo chmod +x ../../bin/packager",
      "sudo mkdir project",
      "sudo mkdir project/src",
      "sudo mkdir project/tmp",
      "sudo mkdir project/tmp/origin",
      "sudo mkdir project/tmp/converted",
      "sudo mkdir project/tmp/packaged",

      // "cd project/src",
      // "sudo pip3 install boto3 .",
      // "sudo pip3 install ec2-metadata",
    ]
  }

  provisioner "file" {
    source      = "src/main.py"
    destination = "/tmp/main.py"
    // destination = "/home/ubuntu/project/src/main.py"
  }

  provisioner "shell" {
    inline = ["sudo mv /tmp/main.py /home/ubuntu/project/src/main.py"]
  }
}
