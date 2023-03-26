resource "null_resource" "deploy_files" {    
  triggers = {
    dir_sha1 = sha1(join("", [for f in fileset(".", "../app/*"): filesha1(f)]))
  }

  # provisioner "file" { ... }
  provisioner "local-exec" { 
    command = "echo Change Detected"
   }
}