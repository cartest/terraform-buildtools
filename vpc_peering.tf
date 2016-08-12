module "vpc_peering_connections" {
  source                = "github.com/Zordrak/terraform-vpc-peering.git"
  environment           = "${var.environment}"
  peer_vpcs             = "${var.peer_vpcs}"
  project               = "${var.project}"
  source_aws_account_id = "${var.aws_account_id}"
  source_vpc_id         = "${aws_vpc.vpc.id}"
}
