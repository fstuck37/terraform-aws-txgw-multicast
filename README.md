AWS Transit Gateway
=============

This module deploys an AWS Transit Gateway that supports multicast.

Example
------------
```
variable "multicast_group_members" {
  default = {
    eni-11111111111111111 = "224.0.0.10"
    eni-22222222222222222 = "224.0.0.10"
    eni-33333333333333333 = "224.0.0.10"
    eni-aaaaaaaaaaaaaaaaa = "224.0.0.11"
    eni-bbbbbbbbbbbbbbbbb = "224.0.0.11"
    eni-ccccccccccccccccc = "224.0.0.11"
  }
}

module "txgw-multicast" {
  source = "git::https://github.com/fstuck37/terraform-aws-txgw-multicast.git"
  region                          = "eu-west-1"
  auto_accept_shared_attachments  = "disable"
  description                     = "Multicast TXGW"
  vpc_id                          = "vpc-12345678"
  subnet_ids                      = ["subnet-a1234567", "subnet-b1234567"]
  auto_accept_shared_associations = "disable"
  static_sources_support          = "disable"
  multicast_group_members         = var.multicast_group_members
}
```

Argument Reference
------------
* **Settings**
  * **region** - Required : The AWS Region to deploy the Transit Gateway to
  * **name** - Optional : The name of the transit gateway. The default is txgw-multicast
  * **multicast_domain_name** - Optional : The name of the multicast domain. The default is multicast_domain
  * **vpc_attachment_name** - Required : The name of the VPC attachment. Default us multicast_attachment.
  * **amazon_side_asn** - Optional: Private Autonomous System Number (ASN) for the Amazon side of a BGP session. The range is 64512 to 65534 for 16-bit ASNs and 4200000000 to 4294967294 for 32-bit ASNs. Default value: 64512.
  * **auto_accept_shared_attachments** - Optional: Whether resource attachment requests are automatically accepted. Valid values: disable, enable. Default value: enable.
  * **default_route_table_association** - Optional: Whether resource attachments are automatically associated with the default association route table. Valid values: disable, enable. Default value: enable.
  * **default_route_table_propagation** - Optional: Whether resource attachments automatically propagate routes to the default propagation route table. Valid values: disable, enable. Default value: enable.
  * **description** - Optional: Description of the EC2 Transit Gateway.
  * **dns_support** - Optional: Whether DNS support is enabled. Valid values: disable, enable. Default value: enable.
  * **vpn_ecmp_support** - Optional: Whether VPN Equal Cost Multipath Protocol support is enabled. Valid values: disable, enable. Default value: enable.
  * **tags** - Optional : A map of tags to assign to the resource.
  * **transit_gateway_cidr_blocks** - Optional: One or more IPv4 or IPv6 CIDR blocks for the transit gateway. Must be a size /24 CIDR block or larger for IPv4, or a size /64 CIDR block or larger for IPv6.
  * **vpc_id** - Required: The VPC ID to attach the transit gateway to.
  * **subnet_ids** - Required: List of subnet IDs to attach the transit gateway to.
  * **auto_accept_shared_associations** - Optional: Whether to automatically accept cross-account subnet associations that are associated with the EC2 Transit Gateway Multicast Domain. Valid values: disable, enable. Default value: enable.
  * **igmpv2_support** - Optional: Whether to enable Internet Group Management Protocol (IGMP) version 2 for the EC2 Transit Gateway Multicast Domain. Valid values: disable, enable. Default value: enable.
  * **static_sources_support** - Optional: Whether to enable support for statically configuring multicast group sources for the EC2 Transit Gateway Multicast Domain. Valid values: disable, enable. Default value: disable.
  * **multicast_group_members** - Required: The ENIs to add to the group ip address

Output Reference
------------
  * **arn** - EC2 Transit Gateway Amazon Resource Name (ARN)
  * **association_default_route_table_id** - Identifier of the default association route table
  * **id** - EC2 Transit Gateway identifier
  * **owner_id** - Identifier of the AWS account that owns the EC2 Transit Gateway
  * **propagation_default_route_table_id** - Identifier of the default propagation route table.