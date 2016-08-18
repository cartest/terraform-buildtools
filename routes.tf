resource "aws_route" "public_default" {
  route_table_id         = "${aws_route_table.public.id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.internet_gateway.id}"
}

resource "aws_route" "public_vpc_peers" {
  count                     = "${length(var.peer_matrix)}"
  route_table_id            = "${aws_route_table.public.id}"
  destination_cidr_block    = "${element(split(",", element(var.peer_matrix, count.index)), 2)}"
  vpc_peering_connection_id = "${var.peering_connections[count.index]}"
}

resource "aws_route" "private_nonat_vpc_peers" {
  count                     = "${length(var.peer_matrix)}"
  route_table_id            = "${aws_route_table.private_nonat.id}"
  destination_cidr_block    = "${element(split(",", element(var.peer_matrix, count.index)), 2)}"
  vpc_peering_connection_id = "${var.peering_connections[count.index]}"
}

resource "aws_route" "private_nats_vpc_peers" {
  count                     = "${length(var.peer_matrix) * var.region_az_count}"
  route_table_id            = "${element(aws_route_table.private_nats.*.id, count.index % var.region_az_count)}"
  destination_cidr_block    = "${element(split(",", element(var.peer_matrix, count.index / var.region_az_count)), 2)}"
  vpc_peering_connection_id = "${var.peering_connections[count.index / var.region_az_count]}"
}
