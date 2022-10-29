resource "aws_instance" "myEc2" {
  ami           = "ami-062df10d14676e201"
  instance_type = "t2.micro"
  key_name      = "-"
  vpc_security_group_ids = [
    "launch-wizard-6"
  ]
    user_data = <<-EOL
      #!/bin/bash -xe

      apt update
      sudo apt install ffmpeg -y

      cd /home/ubuntu/
      mkdir video
      cd video
      wget https://www.sample-videos.com/video123/mp4/720/big_buck_bunny_720p_1mb.mp4 -O video2.mp4

      EOL

  tags = {
    Name = "testInstall"
  }
}

# resource "tls_private_key" "example" {
#   algorithm = "RSA"
#   rsa_bits  = 4096
# }

# resource "aws_key_pair" "generated_key" {
#   key_name   = "Xmykey"
#   public_key = tls_private_key.example.public_key_openssh
# }

# resource "aws_instance" "myEc2" {
#   ami           = "ami-062df10d14676e201"
#   instance_type = "t2.micro"
#   # key_name      = "mediaconverterkey"
#   key_name      = aws_key_pair.generated_key.key_name
#   vpc_security_group_ids = [
#     "launch-wizard-6"
#   ]

#   tags = {
#     Name = "myec21"
#   }
# }

# output "private_key" {
#   value     = tls_private_key.example.private_key_pem
#   sensitive = true
# }
