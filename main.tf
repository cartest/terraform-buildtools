# This is a temporary way to invoke the environment using the bootstrap module.
# This in future will be run as an explicitly seperate Jenkins slave job, not invoked here
module "environment" {
  source                          = "github.com/Zordrak/terraform-environment.git"
  aws_region                      = "${var.aws_region}"
  vpc_id                          = "${aws_vpc.vpc.id}"
  environment                     = "${var.environment}"
  project                         = "${var.project}"
  region_az_count                 = "${var.region_az_count}"
  internet_gateway_id             = "${aws_internet_gateway.internet_gateway.id}"
  bootstrap_public_route_table_id = "${aws_route_table.public.id}"
}
