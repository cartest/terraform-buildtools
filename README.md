# terraform-bootstrap
Environment Bootstrap terraform module

Creates:
   * A VPC
   * DHCP Options
   * A public route table
   * An internet gateway
   * A flow log (to be used as output or remote state into cwles)
   * A Jenkins slave microservice
   * A Route53 Private Hosted Zone
   * VPC Peering connections


# Limitations:
- After first terraform apply we can't change list: ha-nat_subnets_cidrs param.

Example:
```
> cat buildTools_example.tf
module buildtools {
  source      = "git::https://github.com/cartest/terraform-buildtools"
  environment = "buildtools-env"
  project     = "mot2"
  ha-nat_subnets_cidrs  = ["10.222.1.0/24"]
  private_dns_domain = "mot2-buildtools-domain"
  vpc_cidr = "10.222.0.0/16"
}
```
```
> terraform apply
(...) <- OK message
```

Extending list: ha-nat_subnets_cidrs
```
> cat buildTools_example.tf
module buildtools {
  source      = "git::https://github.com/cartest/terraform-buildtools"
  environment = "buildtools-env"
  project     = "mot2"
  ha-nat_subnets_cidrs  = ["10.222.1.0/24", "10.222.2.0/24"]
  private_dns_domain = "mot2-buildtools-domain"
  vpc_cidr = "10.222.0.0/16"
}
```
Plan looks legit:
```
Angel:step1 dawidm$ terraform plan
Refreshing Terraform state in-memory prior to plan...
The refreshed state will be used to calculate this plan, but
will not be persisted to local or remote state storage.

module.buildtools.aws_iam_role.flow_log: Refreshing state... (ID: buildtools-env-mot2-FLR)
module.buildtools.aws_vpc.vpc: Refreshing state... (ID: vpc-69149a0d)
module.buildtools.aws_vpc_dhcp_options.vpc_dhcp_options: Refreshing state... (ID: dopt-e58b8780)
module.buildtools.data.aws_availability_zones.available: Refreshing state...
module.buildtools.aws_iam_role_policy.flow_logs_policy: Refreshing state... (ID: buildtools-env-mot2-FLR:buildtools-env-mot2-FLP)
module.buildtools.ha-nat.aws_eip.eips.0: Refreshing state... (ID: eipalloc-5b2d313e)
module.buildtools.aws_route_table.private_nonat: Refreshing state... (ID: rtb-d6aee6b2)
module.buildtools.aws_route_table.private_nats.0: Refreshing state... (ID: rtb-d7aee6b3)
module.buildtools.aws_route_table.public: Refreshing state... (ID: rtb-d5aee6b1)
module.buildtools.aws_vpc_dhcp_options_association.dhcp_options_association: Refreshing state... (ID: dopt-e58b8780-vpc-69149a0d)
module.buildtools.aws_internet_gateway.internet_gateway: Refreshing state... (ID: igw-22b6a047)
module.buildtools.aws_flow_log.flow_log: Refreshing state... (ID: fl-4aef0f23)
module.buildtools.aws_route53_zone.private: Refreshing state... (ID: ZOLKDJ6KODFJT)
module.buildtools.aws_vpc_endpoint.s3: Refreshing state... (ID: vpce-4857b921)
module.buildtools.aws_route.public_default: Refreshing state... (ID: r-rtb-d5aee6b11080289494)
module.buildtools.ha-nat.subnets.aws_subnet.subnets.0: Refreshing state... (ID: subnet-7f3ba109)
module.buildtools.ha-nat.subnets.aws_route_table_association.route_table_associations.0: Refreshing state... (ID: rtbassoc-d9ea4ebe)
module.buildtools.ha-nat.aws_nat_gateway.nat_gateways.0: Refreshing state... (ID: nat-087ce2028833936fb)
module.buildtools.aws_route_table_association.ha-nat_public.0: Refreshing state... (ID: rtbassoc-d9ea4ebe)
module.buildtools.ha-nat.aws_route.private_nats-to-nat_gateways.0: Refreshing state... (ID: r-rtb-d7aee6b31080289494)

The Terraform execution plan has been generated and is shown below.
Resources are shown in alphabetical order for quick scanning. Green resources
will be created (or destroyed and then created if an existing resource
exists), yellow resources are being changed in-place, and red resources
will be destroyed. Cyan entries are data sources to be read.

Note: You didn't specify an "-out" parameter to save this plan, so when
"apply" is called, Terraform can't guarantee this is what will execute.

+ module.buildtools.aws_route_table.private_nats.1
    route.#:          "<computed>"
    tags.%:           "4"
    tags.Application: "mot2"
    tags.Environment: "buildtools-env"
    tags.Name:        "buildtools-env-mot2-PRI-NAT-RT"
    tags.Tier:        "PRI"
    vpc_id:           "vpc-69149a0d"

-/+ module.buildtools.aws_route_table_association.ha-nat_public.0
    route_table_id: "rtb-d5aee6b1" => "rtb-d5aee6b1"
    subnet_id:      "subnet-7f3ba109" => "${module.ha-nat.subnet_ids[count.index]}" (forces new resource)

+ module.buildtools.aws_route_table_association.ha-nat_public.1
    route_table_id: "rtb-d5aee6b1"
    subnet_id:      "${module.ha-nat.subnet_ids[count.index]}"

~ module.buildtools.aws_vpc_endpoint.s3
    route_table_ids.#: "" => "<computed>"

+ module.buildtools.ha-nat.aws_eip.eips.1
    allocation_id:     "<computed>"
    association_id:    "<computed>"
    domain:            "<computed>"
    instance:          "<computed>"
    network_interface: "<computed>"
    private_ip:        "<computed>"
    public_ip:         "<computed>"
    vpc:               "true"

-/+ module.buildtools.ha-nat.aws_nat_gateway.nat_gateways.0
    allocation_id:        "eipalloc-5b2d313e" => "${element(aws_eip.eips.*.id, count.index)}" (forces new resource)
    network_interface_id: "eni-7cc47a30" => "<computed>"
    private_ip:           "10.222.1.162" => "<computed>"
    public_ip:            "52.210.149.233" => "<computed>"
    subnet_id:            "subnet-7f3ba109" => "${element(module.subnets.subnet_ids, count.index)}" (forces new resource)

+ module.buildtools.ha-nat.aws_nat_gateway.nat_gateways.1
    allocation_id:        "${element(aws_eip.eips.*.id, count.index)}"
    network_interface_id: "<computed>"
    private_ip:           "<computed>"
    public_ip:            "<computed>"
    subnet_id:            "${element(module.subnets.subnet_ids, count.index)}"

~ module.buildtools.ha-nat.aws_route.private_nats-to-nat_gateways.0
    nat_gateway_id: "nat-087ce2028833936fb" => "${element(aws_nat_gateway.nat_gateways.*.id, count.index)}"
    route_table_id: "rtb-d7aee6b3" => "${element(var.nat_route_tables, count.index)}"

+ module.buildtools.ha-nat.aws_route.private_nats-to-nat_gateways.1
    destination_cidr_block:     "0.0.0.0/0"
    destination_prefix_list_id: "<computed>"
    gateway_id:                 "<computed>"
    instance_id:                "<computed>"
    instance_owner_id:          "<computed>"
    nat_gateway_id:             "${element(aws_nat_gateway.nat_gateways.*.id, count.index)}"
    network_interface_id:       "<computed>"
    origin:                     "<computed>"
    route_table_id:             "${element(var.nat_route_tables, count.index)}"
    state:                      "<computed>"

-/+ module.buildtools.ha-nat.subnets.aws_route_table_association.route_table_associations.0
    route_table_id: "rtb-d5aee6b1" => "rtb-d5aee6b1"
    subnet_id:      "subnet-7f3ba109" => "${element(aws_subnet.subnets.*.id, count.index)}" (forces new resource)

+ module.buildtools.ha-nat.subnets.aws_route_table_association.route_table_associations.1
    route_table_id: "rtb-d5aee6b1"
    subnet_id:      "${element(aws_subnet.subnets.*.id, count.index)}"

+ module.buildtools.ha-nat.subnets.aws_subnet.subnets.1
    availability_zone:       "eu-west-1b"
    cidr_block:              "10.222.2.0/24"
    map_public_ip_on_launch: "false"
    tags.%:                  "5"
    tags.Application:        "mot2"
    tags.Environment:        "buildtools-env"
    tags.Name:               "buildtools-env-mot2-PUB-ha-nat-SUB-eu-west-1b"
    tags.Role:               "ha-nat"
    tags.Tier:               "PUB"
    vpc_id:                  "vpc-69149a0d"


Plan: 10 to add, 2 to change, 3 to destroy.
```
But apply throws an error:
```
Error applying plan:

1 error(s) occurred:

* aws_route.private_nats-to-nat_gateways.0: diffs didn't match during apply. This is a bug with Terraform and should be reported as a GitHub Issue.

Please include the following information in your report:

    Terraform Version: 0.7.3
    Resource ID: aws_route.private_nats-to-nat_gateways.0
    Mismatch reason: attribute mismatch: route_table_id
    Diff One (usually from plan): *terraform.InstanceDiff{mu:sync.Mutex{state:0, sema:0x0}, Attributes:map[string]*terraform.ResourceAttrDiff{"route_table_id":*terraform.ResourceAttrDiff{Old:"rtb-d7aee6b3", New:"${element(var.nat_route_tables, count.index)}", NewComputed:false, NewRemoved:false, NewExtra:interface {}(nil), RequiresNew:false, Sensitive:false, Type:0x0}, "nat_gateway_id":*terraform.ResourceAttrDiff{Old:"nat-087ce2028833936fb", New:"${element(aws_nat_gateway.nat_gateways.*.id, count.index)}", NewComputed:false, NewRemoved:false, NewExtra:interface {}(nil), RequiresNew:false, Sensitive:false, Type:0x0}}, Destroy:false, DestroyTainted:false}
    Diff Two (usually from apply): *terraform.InstanceDiff{mu:sync.Mutex{state:0, sema:0x0}, Attributes:map[string]*terraform.ResourceAttrDiff{"nat_gateway_id":*terraform.ResourceAttrDiff{Old:"nat-087ce2028833936fb", New:"nat-069fa1fd985386772", NewComputed:false, NewRemoved:false, NewExtra:interface {}(nil), RequiresNew:false, Sensitive:false, Type:0x0}}, Destroy:false, DestroyTainted:false}

Also include as much context as you can about your config, state, and the steps you performed to trigger this error.


Terraform does not automatically rollback in the face of errors.
Instead, your Terraform state file has been partially updated with
any resources that successfully completed. Please address the error
above and apply again to incrementally change your infrastructure.
```
