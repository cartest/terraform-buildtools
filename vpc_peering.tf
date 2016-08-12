module "vpc_peering_connections" {
  source                = "../terraform-vpc-peering"
  environment           = "${var.environment}"
  peer_matrix           = "${var.peer_matrix}"
  project               = "${var.project}"
  source_vpc_id         = "${aws_vpc.vpc.id}"
}
