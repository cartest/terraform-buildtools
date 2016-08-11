module "microservice_jenkinsslave" {
  source                          = "github.com/Zordrak/terraform-microservice.git"
  additional_security_group_ids   = []
  asg_size_max                    = "1"
  asg_size_min                    = "1"
  availability_zones              = "${data.aws_availability_zones.available.names}"
  aws_region                      = "${var.aws_region}"
  lc_ami_id                       = "ami-00000000000000000"
  lc_instance_type                = "c4.xlarge"
  name                            = "jenkins"
  subnets_cidr                    = ["10.0.0.0/24", "10.0.1.0/24", "10.0.2.0/24"]
  subnets_map_public_ip_on_launch = true
  subnets_route_tables            = ["${aws_route_table.public.id}"]
  vpc_id                          = "${aws_vpc.vpc.id}"

  tags {
    Environment = "${var.environment}"
    Application = "${var.project}"
    Tier        = "PUB"
    Role        = "jenkinsslave"
  }
}

resource "aws_route_table_association" "jenkinsslave-public" {
  count          = "${var.region_az_count}"
  subnet_id      = "${module.microservice_jenkins.subnet_ids[count.index]}"
  route_table_id = "${aws_route_table.public.id}"
}
