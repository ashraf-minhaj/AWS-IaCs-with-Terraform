# zip -r x.zip x 

locals {
  cloud_config_config = <<-END
    #cloud-config
    ${jsonencode({
      write_files = [
        {
          path        = "/home/ubuntu/project/x.zip"
          permissions = "0644"
          # owner       = "root:root"
          encoding    = "b64"
          content     = filebase64("${path.module}/x/x.zip")
        },
      ]
    })}
  END
}

data "cloudinit_config" "example" {
  gzip          = false
  base64_encode = false

  part {
    content_type = "text/cloud-config"
    filename     = "cloud-config.yaml"
    content      = local.cloud_config_config
  }

  part {
    content_type = "text/x-shellscript"
    filename     = "setup.sh"
    content  = <<-EOF
      #!/bin/bash

      sudo apt update && sudo apt upgrade -y
      echo "done"
      sudo apt-get install unzip -y
      sudo apt-get install ffmpeg -y

      wget https://www.sample-videos.com/video123/mp4/720/big_buck_bunny_720p_1mb.mp4 -O /home/ubuntu/outside.mp4
    EOF
  }

  part {
    content_type = "text/x-shellscript"
    filename     = "unzip_project.sh"
    content  = <<-EOF
      #!/bin/bash

      cd /home/ubuntu/project
      sudo unzip x.zip

      cd ../
      mkdir video
      cd video
      wget https://www.sample-videos.com/video123/mp4/720/big_buck_bunny_720p_1mb.mp4 -O videoX.mp4
    EOF
  }
}


resource "aws_instance" "myEc2" {
  ami           = "ami-062df10d14676e201"
  instance_type = "t2.micro"
  key_name      = "mediaconverterkey"
  vpc_security_group_ids = ["launch-wizard-6"]
  
  # # don't use !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
  # # Copies the configs.d folder to /etc/configs.d
  # provisioner "file" {
  #   source      = "x/index.html"
  #   destination = "/home/ubuntu/"
  # }

  # user_data = <<-EOL
  #     #!/bin/bash -xe

  #     apt update
  #     sudo apt install ffmpeg -y

  #     cd /home/ubuntu/
  #     mkdir video
  #     cd video
  #     wget https://www.sample-videos.com/video123/mp4/720/big_buck_bunny_720p_1mb.mp4 -O video2.mp4
  #   EOL

  user_data = data.cloudinit_config.example.rendered

  tags = {
    Name = "testInstall"
  }
}