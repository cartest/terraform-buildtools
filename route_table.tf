resource "aws_route_table" "public" {
  vpc_id = "${aws_vpc.vpc.id}"

  tags {
    Name        = "${var.environment}-${var.project}-PUB-BOOTSTRAP-RT"
    Environment = "${var.environment}"
    Application = "${var.project}"
    Tier        = "PUB"
  }
}
