resource "null_resource" "provision_img" {    
  triggers = {
    dir_sha1 = sha1(join("", [for f in fileset(".", "../app/*"): filesha1(f)]))
  }

  # provisioner "file" { ... }
  provisioner "local-exec" { 
    # command = "echo Change Detected"
    command = "cd ../scripts; bash build_img.sh"
   }
}