resource "aws_acm_certificate" "multi_shop_certificate" {
  domain_name       = "multi-shop.tosinfletcher.com"
  validation_method = "DNS"

  tags = {
    Name = "multi_shop_certificate"
  }
}
