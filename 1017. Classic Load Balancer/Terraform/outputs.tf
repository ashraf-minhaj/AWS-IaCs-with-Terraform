output "security_group_id" {
  value = aws_security_group.ec2_security_group.id
}

output "lb_dns" {
  value = aws_elb.load_balancer.dns_name
}

output "backend_domain_name" {
  value = aws_route53_record.subdomain_record.name
}