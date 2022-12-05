data "aws_ami" "ami" {
  most_recent = true
  owners = ["self"]
  filter {
    name = "name"
    values = ["learn-packer-linux-aws"]
  }
}

output "ami_id" {
  value = data.aws_ami.ami.id
}

resource "aws_instance" "myEc2" {
  ami = data.aws_ami.ami.id
  instance_type = "t2.micro"
  key_name      = "----key"
  vpc_security_group_ids = [
    "launch-wizard-18"
  ]
    user_data = <<-EOL
      #!/bin/bash -xe
      sudo wget https://www.sample-videos.com/video123/mp4/720/big_buck_bunny_720p_1mb.mp4 -O /home/ubuntu/dpnd_comp.mp4
      EOL

  tags = {
    Name = "learn-packer-linux-aws-child"
  }
}
