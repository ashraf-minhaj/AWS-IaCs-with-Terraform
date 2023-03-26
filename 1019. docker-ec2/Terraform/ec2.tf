resource "aws_instance" "myEc2" {
  ami                     = "ami-062df10d14676e201"
  instance_type           = "t2.micro"
  # key_name                = "testminserverkeys.pem"
  # vpc_security_group_ids  = ["launch-wizard-6"]
  user_data               = "${filebase64("../scripts/simple_page.sh")}"

  tags = {
    Name                  = "test-minhaj"
  }
}
