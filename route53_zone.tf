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

# resource "aws_route53_zone_association" "route53_zone_association_private" {


#   zone_id = "${aws_route53_zone.private.id}"


#   vpc_id  = "${aws_vpc.vpc.id}"


# }

