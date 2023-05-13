data "aws_acm_certificate" "certificate" {
  provider  = aws.virginia
  domain    = "${var.subdomain_name}.${data.aws_route53_zone.zone.name}"
  # statuses  = ["ISSUED"]
}