output "vpc_id" {
  value = "${aws_vpc.vpc.id}"
}

output "private_hosted_zone_id" {
  value = "${aws_route53_zone.private.id}"
}

output "internet_gateway_id" {
  value = "${aws_internet_gateway.internet_gateway.id}"
}

output "flow_log_id" {
  value = "${aws_flow_log.flow_log.id}"
}

output "bootstrap_public_route_table_id" {
  value = "aws_route_table.public.id"
}

output "aws_region" {
  value = "${var.aws_region}"
}

output "environment" {
  value = "${var.environment}"
}

output "project" {
  value = "${var.project}"
}
