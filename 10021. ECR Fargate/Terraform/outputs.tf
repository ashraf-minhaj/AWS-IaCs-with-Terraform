output "image" {
    value = data.aws_ecr_image.service_image
}

output "subnets" {
    value = data.aws_subnets.default.ids
}