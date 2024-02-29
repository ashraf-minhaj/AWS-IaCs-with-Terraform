output "security_group_id" {
  value = aws_security_group.ec2_security_group.id
}

# output "lb_dns" {
#   value = aws_lb.load_balancer.dns_name
# }

# output "backend_domain_name" {
#   value = aws_route53_record.subdomain_record.name
# }

# output "lb_ip_address" {
#   value = data.dns_a_record_set.lb_ips
# }

# output "docker_image_tag" {
#   value = local.docker_image_tag
# }

# output "cdn_url" {
#   value = "${var.cdn_subdomain_name}.${data.aws_route53_zone.zone.name}"
# }