resource "aws_ecr_repository" "frontend_repo" {
  name                 = var.frontend_repo_name
  image_tag_mutability = "MUTABLE" # Or "IMMUTABLE" based on your needs

  image_scanning_configuration {
    scan_on_push = false # Set to true if you want to scan images as they are pushed
  }
}

locals {
  frontend_hash = filebase64sha256("${path.module}/${var.frontend_dir}/Dockerfile")
}

resource "random_id" "frontend_rand_tag" {
  keepers = {
    # Generate a new tag each time there's change in Dockerfile hash
    frontend_img_tag = local.frontend_hash
  }

  byte_length = 2
}

resource "null_resource" "build_and_push_frontend" {
  triggers = {
    # Trigger a rebuild if the Dockerfile or source code changes
    dockerfile_hash = local.frontend_hash
  }

  provisioner "local-exec" {
    command = <<-EOT
      aws ecr get-login-password --region ${var.aws_region} | docker login --username AWS --password-stdin ${aws_ecr_repository.frontend_repo.repository_url}
      docker build -t ${aws_ecr_repository.frontend_repo.repository_url}:${random_id.frontend_rand_tag.hex} ${path.module}/${var.frontend_dir}
      docker push ${aws_ecr_repository.frontend_repo.repository_url}:${random_id.frontend_rand_tag.hex}
    EOT
  }
}

output "image_tag" {
  value = {
    frontend_tag = random_id.frontend_rand_tag.hex
  }
}