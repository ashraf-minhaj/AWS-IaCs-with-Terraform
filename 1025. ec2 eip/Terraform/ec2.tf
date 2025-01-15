resource "aws_instance" "server_instance" {
  ami           = "ami-07b69f62c1d38b012" # Amazon Linux 2023
  instance_type = "t2.micro"             # Free-tier eligible
  key_name      = "min-new-keys"   # Replace with your SSH key name

  user_data = file("../scripts/user_data.sh")       # User data file for server setup

  security_groups = [
    aws_security_group.server_sg.name
  ]

  tags = {
    Name = "server-instance"
  }
}

# Associate an Existing Elastic IP with EC2
resource "aws_eip_association" "server_eip_assoc" {
  instance_id   = aws_instance.server_instance.id
  allocation_id = "eipalloc-0898760f52e474236" # Replace with your Elastic IP Allocation ID
}