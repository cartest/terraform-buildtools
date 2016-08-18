resource "aws_vpc_endpoint" "s3" {
  vpc_id       = "${aws_vpc.vpc.id}"
  service_name = "com.amazonaws.${var.aws_region}.s3"

  route_table_ids = [
    "${aws_route_table.public.id}",
    "${aws_route_table.private_nonat.id}",
    "${aws_route_table.private_nats.*.id}",
  ]
}
