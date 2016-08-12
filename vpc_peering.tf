module "vpc_peers" {
  source                = "github.com/Zordrak/terraform-vpc-peering.git"
  aws_region            = "${var.aws_region}"
  source_aws_account_id = "${var.aws_account_id}"
  source_vpc_id         = "${var.vpc_id}"
  peer_vpcs             = "${var.peer_vpcs}"
}
