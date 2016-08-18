module "ha-nat" {
  source               = "../terraform-ha-nat"
  availability_zones   = "${data.aws_availability_zones.available.names}"
  aws_region           = "${var.aws_region}"
  name                 = "ha-nat"
  nat_route_tables     = ["${aws_route_table.private_nats.*.id}"]
  subnets_cidrs        = ["${var.ha-nat_subnets_cidrs}"]
  subnets_route_tables = ["${aws_route_table.public.id}"]
  vpc_id               = "${aws_vpc.vpc.id}"

  tags {
    Environment = "${var.environment}"
    Application = "${var.project}"
    Tier        = "PUB"
  }
}

resource "aws_route_table_association" "ha-nat_public" {
  count          = "${var.region_az_count}"
  subnet_id      = "${module.ha-nat.subnet_ids[count.index]}"
  route_table_id = "${aws_route_table.public.id}"
}
