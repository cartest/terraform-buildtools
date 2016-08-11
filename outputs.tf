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
