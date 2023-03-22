data "aws_route53_zone" "zone" {
  name      = "${var.hosted_zone_name}"
}

resource "aws_route53_record" "subdomain_record" {
  zone_id   = "${data.aws_route53_zone.zone.zone_id}"
  name      = "${var.subdomain_name}.${data.aws_route53_zone.zone.name}"
  # A – Routes traffic to an IPv4 address and some AWS resources
  type      = "CNAME"         
  ttl       = "300"
  records   = [aws_elb.load_balancer.dns_name]
}