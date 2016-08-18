resource "aws_route53_zone" "private" {
  name    = "${var.private_dns_domain}"
  comment = "${var.environment}-${var.project}-PRI-R53"
  vpc_id  = "${aws_vpc.vpc.id}"

  tags {
    Name        = "${var.environment}-${var.project}-PRI-R53"
    Environment = "${var.environment}"
    Application = "${var.project}"
    Tier        = "PRI"
  }
}
