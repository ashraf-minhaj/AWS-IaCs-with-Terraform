output "instance_id" {
    value = aws_instance.ec2_instance.id
}

output "instance_dns" {
    value = aws_instance.ec2_instance.public_dns
}

output "cludfront_dns" {
    value = aws_cloudfront_distribution.cdn_distribution.domain_name
}