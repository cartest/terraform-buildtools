output "availability_zones" {
  value = ["${data.aws_availability_zones.available.names}"]
}

output "aws_region" {
  value = "${var.aws_region}"
}

output "environment" {
  value = "${var.environment}"
}

output "flow_log_id" {
  value = "${aws_flow_log.flow_log.id}"
}

output "flow_log_iam_role_arn" {
  value = "${aws_iam_role.flow_log.arn}"
}

output "internet_gateway_id" {
  value = "${aws_internet_gateway.internet_gateway.id}"
}

output "nat_gateway_elastic_ip_ids" {
  value = ["${module.ha-nat.eip_ids}"]
}

output "nat_gateway_elastic_ip_public_ips" {
  value = ["${module.ha-nat.eip_public_ips}"]
}

output "nat_gateway_ids" {
  value = ["${module.ha-nat.nat_gateway_ids}"]
}

output "nat_subnet_ids" {
  value = ["${module.ha-nat.subnet_ids}"]
}

output "private_hosted_zone_id" {
  value = "${aws_route53_zone.private.id}"
}

output "private_nat_route_table_ids" {
  value = ["${aws_route_table.private_nats.*.id}"]
}

output "private_nonat_route_table_id" {
  value = "${aws_route_table.private_nonat.id}"
}

output "project" {
  value = "${var.project}"
}

output "public_route_table_id" {
  value = "${aws_route_table.public.id}"
}

output "s3_vpc_endpoint_id" {
  value = "${aws_vpc_endpoint.s3.id}"
}

output "vpc_dhcp_options_id" {
  value = "${aws_vpc_dhcp_options.vpc_dhcp_options.id}"
}

output "vpc_id" {
  value = "${aws_vpc.vpc.id}"
}
