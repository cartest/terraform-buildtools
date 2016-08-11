resource "aws_vpc_dhcp_options" "vpc_dhcp_options" {
  domain_name         = "${var.private_dns_domain}"
  domain_name_servers = ["${cidrhost(var.vpc_cidr, 2)}"]

  tags {
    "Name"        = "${var.environment}-${var.project}-CORE-DHCP"
    "Environment" = "${var.environment}"
    "Application" = "${var.project}"
    "Tier"        = "CORE"
  }
}

resource "aws_vpc_dhcp_options_association" "dhcp_options_association" {
  vpc_id          = "${aws_vpc.vpc.id}"
  dhcp_options_id = "${aws_vpc_dhcp_options.vpc_dhcp_options.id}"
}
