resource "aws_ecr_repository" "repository" {
    name                    = "repository-test"
    # mutable = changeable, immmutable is opposite of this
    image_tag_mutability    = "MUTABLE" 
    force_delete            = true

    # image_scanning_configuration {
    #     scan_on_push    = true
    # }
}

resource "aws_ecr_repository_policy" "my_repository_policy" {
  repository = aws_ecr_repository.repository.name

  policy = <<EOF
{
  "Version": "2008-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": "*",
      "Action": [
        "ecr:GetDownloadUrlForLayer",
        "ecr:BatchCheckLayerAvailability",
        "ecr:BatchGetImage",
        "ecr:InitiateLayerUpload",
        "ecr:UploadLayerPart",
        "ecr:CompleteLayerUpload",
        "ecr:PutImage"
      ]
    }
  ]
}
EOF
}

data "aws_ecr_image" "service_image" {
    repository_name = aws_ecr_repository.repository.name
    # most_recent       = true
    image_tag       = "1"
}