resource "aws_route53_record" "alb" {
  zone_id = var.zone_id
  name    = var.alb_domain
  type    = "CNAME"
  ttl     = 300
  records = [aws_lb.main.dns_name]
}

resource "aws_acm_certificate" "alb" {
  domain_name       = var.alb_domain
  validation_method = "DNS"

  tags = merge(
    var.tags,
    { Name = "${var.name}-main" }
  )
}

# Create AWS Route 53 Certificate Validation Record
resource "aws_route53_record" "linux-alb-certificate-validation-record" {
  for_each = {
    for dvo in aws_acm_certificate.alb.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }
  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 60
  type            = each.value.type
  zone_id         = var.zone_id
}

# Create Certificate Validation
resource "aws_acm_certificate_validation" "linux-certificate-validation" {
  certificate_arn         = aws_acm_certificate.alb.arn
  validation_record_fqdns = [for record in aws_route53_record.linux-alb-certificate-validation-record : record.fqdn]
}
