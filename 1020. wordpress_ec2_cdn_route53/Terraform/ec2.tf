locals {
  cloud_config = <<-END
    #cloud-config
    ${jsonencode({
      write_files = [
        {
          path        = "install_dependencies.sh"
          permissions = "0644"
          # owner       = "root:root"
          encoding    = "b64"
          content     = filebase64("../scripts/install_dependencies.sh")
        },
      ]
    })}
  END
}

data "cloudinit_config" "cloudinit" {
    gzip              = false
    base64_encode     = false

    part {
        content_type  = "text/x-shellscript"
        filename      = "cloud-config.yaml"
        content       = local.cloud_config
    }
    part {
    content_type      = "text/x-shellscript"
    filename          = "run_script.sh"
    content           = <<-EOF
        #!/bin/bash
        bash install_dependencies.sh ${var.db_user_name} ${var.db_admin_pass}
        # sudo bash install_dependencies.sh ph_wp_admin 123
    EOF
    }  
}


resource "aws_instance" "ec2_instance" {
    ami                         = var.ami
    instance_type               = var.instance_type
    key_name                    = var.key_name
    vpc_security_group_ids      = [ "${var.security_group_name}" ]
    
    user_data                   = data.cloudinit_config.cloudinit.rendered
    # user_data_replace_on_change = true

    tags = {
        Name                    = "${var.component_name}"
        app                     = "${var.common_value}"
    }
}
