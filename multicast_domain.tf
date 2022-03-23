resource "aws_ec2_transit_gateway_multicast_domain" "multicast_domain" {
  transit_gateway_id = aws_ec2_transit_gateway.txgw.id
  auto_accept_shared_associations = var.auto_accept_shared_associations
  igmpv2_support                  = var.igmpv2_support
  static_sources_support          = var.static_sources_support
  tags                            = merge(var.tags,tomap("Name" = var.multicast_domain_name))
}

resource "aws_ec2_transit_gateway_multicast_domain_association" "multicast_domain_association" {
  for_each = { for sn in var.subnet_ids : sn => sn }
    subnet_id                           = each.value
    transit_gateway_attachment_id       = aws_ec2_transit_gateway_vpc_attachment.vpc_attachment.id
    transit_gateway_multicast_domain_id = aws_ec2_transit_gateway_multicast_domain.multicast_domain.id
}

resource "aws_ec2_transit_gateway_multicast_group_member" "group_member" {
  for_each = var.multicast_group_members
    group_ip_address                    = each.value
    network_interface_id                = each.key
    transit_gateway_multicast_domain_id = aws_ec2_transit_gateway_multicast_domain_association.multicast_domain_association[local.eni-dmid[each.key]].transit_gateway_multicast_domain_id
}


data "aws_subnet" "subnets" {
  for_each = { for sn in var.subnet_ids : sn => sn }
   id = each.value
}

data "aws_network_interface" "enis" {
  for_each = { for eni in keys(var.multicast_group_members) : eni => eni }
  id = each.value
}

locals {
  eni-dmid = {
    for eni in data.aws_network_interface.enis : eni.id => join(", ", [
      for sn in data.aws_subnet.subnets : sn.id
        if sn.availability_zone == eni.availability_zone
    ])
  }
}

