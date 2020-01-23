resource "aws_route53_zone" "FP" {
  name = "FP.Phz"

  vpc {
    vpc_id = aws_vpc.FP.id
  }
}

resource "aws_route53_record" "DSH1" {
  zone_id = aws_route53_zone.FP.zone_id
  name    = "DSH1.FP.Phz"
  type    = "A"
  ttl     = "300"
  records = ["172.20.0.11"]
}
resource "aws_route53_record" "DSH2" {
  zone_id = aws_route53_zone.FP.zone_id
  name    = "DSH2.FP.Phz"
  type    = "A"
  ttl     = "300"
  records = ["172.20.0.12"]
}
resource "aws_route53_record" "DSW1" {
  zone_id = aws_route53_zone.FP.zone_id
  name    = "DSW1.FP.Phz"
  type    = "A"
  ttl     = "300"
  records = ["172.20.0.21"]
}
resource "aws_route53_record" "DSW2" {
  zone_id = aws_route53_zone.FP.zone_id
  name    = "DSW2.FP.Phz"
  type    = "A"
  ttl     = "300"
  records = ["172.20.0.22"]
}
resource "aws_route53_record" "DSW3" {
  zone_id = aws_route53_zone.FP.zone_id
  name    = "DSW3.FP.Phz"
  type    = "A"
  ttl     = "300"
  records = ["172.20.0.23"]
}
