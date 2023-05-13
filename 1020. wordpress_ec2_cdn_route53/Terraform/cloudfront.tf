resource "aws_cloudfront_origin_access_identity" "origin_access_identity" {

}

resource "aws_cloudfront_distribution" "cdn_distribution" {
    origin {
        domain_name                   = aws_instance.ec2_instance.public_dns
        origin_id                     = "${local.origin_id}"
        custom_origin_config {
            http_port                 = 80
            https_port                = 80
            origin_protocol_policy    = "http-only"
            origin_ssl_protocols      = ["TLSv1"]
        }
    }

    enabled                           = true
    # is_ipv6_enabled                   = true
    aliases                           = ["${var.subdomain_name}.${data.aws_route53_zone.zone.name}"]

    default_cache_behavior {
        # allowed_methods         = ["HEAD", "GET", "OPTIONS", "PATCH", "POST", "PUT"]
        allowed_methods               = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
        cached_methods                = ["HEAD", "GET"]
        target_origin_id              = "${local.origin_id}"

    forwarded_values {
        query_string                  = true
        headers                       = ["Origin", "Access-Control-Request-Method", "Access-Control-Request-Headers"]
        cookies {
            forward                   = "none"
        }
    }

    viewer_protocol_policy            = "redirect-to-https"
        min_ttl                       = 0
        default_ttl                   = 3600
        max_ttl                       = 86400
    }

    restrictions {
        geo_restriction {
            restriction_type          = "none"
            }
    }

    price_class                       = "${var.cloudfront_price_class}"

    viewer_certificate {
        # cloudfront_default_certificate  = true
        ssl_support_method            = "sni-only"
        acm_certificate_arn           = "${data.aws_acm_certificate.certificate.arn}"
    }

    tags = {
        description                   = "${var.component_name}-cdn"
        Name                          = "${var.component_name}-cdn"
        app                           = "${var.common_value}"
    }
}