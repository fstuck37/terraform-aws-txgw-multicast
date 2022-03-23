variable "region" {
  type = string
  description = "Required : The AWS Region to deploy the Transit Gateway to"
}

variable "name" {
  type = string
  description = "Required : The name of the transit gateway"
}


variable "amazon_side_asn" {
  type = string
  description = "Optional: Private Autonomous System Number (ASN) for the Amazon side of a BGP session. The range is 64512 to 65534 for 16-bit ASNs and 4200000000 to 4294967294 for 32-bit ASNs. Default value: 64512."
  default = "64512"
}

variable "auto_accept_shared_attachments" {
  type = string
  description = "Optional: Whether resource attachment requests are automatically accepted. Valid values: disable, enable. Default value: enable."
  default = "enable"
}


variable "default_route_table_association" {
  type = string
  description = "Optional: Whether resource attachments are automatically associated with the default association route table. Valid values: disable, enable. Default value: enable."
  default = "enable"
}

variable "default_route_table_propagation" {
  type = string
  description = "Optional: Whether resource attachments automatically propagate routes to the default propagation route table. Valid values: disable, enable. Default value: enable."
  default = "enable"
}

variable "description" {
  type = string
  description = "Optional: Description of the EC2 Transit Gateway."
  default = ""
}

variable "dns_support" {
  type = string
  description = "Optional: Whether DNS support is enabled. Valid values: disable, enable. Default value: enable."
  default = "enable"
}

variable "vpn_ecmp_support" {
  type = string
  description = "Optional: Whether VPN Equal Cost Multipath Protocol support is enabled. Valid values: disable, enable. Default value: enable."
  default = "enable"
}

variable "tags" {
  type = map(string)
  description = "Optional : A map of tags to assign to the resource."
  default = {}
}

variable "transit_gateway_cidr_blocks" {
  type = list(string)
  description = "Optional: One or more IPv4 or IPv6 CIDR blocks for the transit gateway. Must be a size /24 CIDR block or larger for IPv4, or a size /64 CIDR block or larger for IPv6."
  default = []
}

variable "vpc_id" {
  type = string
  description = "Required: The VPC ID to attach the transit gateway to."
}

variable "subnet_ids" {
  type = list(string)
  description = "Required: List of subnet IDs to attach the transit gateway to."
}

variable "auto_accept_shared_associations" {
  type        = string
  description = "Optional: Whether to automatically accept cross-account subnet associations that are associated with the EC2 Transit Gateway Multicast Domain. Valid values: disable, enable. Default value: enable."
  default    = "enable"
}

variable "igmpv2_support" {
  type        = string
  description = "Optional: Whether to enable Internet Group Management Protocol (IGMP) version 2 for the EC2 Transit Gateway Multicast Domain. Valid values: disable, enable. Default value: enable."
  default     = "enable"
}

variable "static_sources_support" {
  type        = string
  description = "Optional: Whether to enable support for statically configuring multicast group sources for the EC2 Transit Gateway Multicast Domain. Valid values: disable, enable. Default value: disable."
  default     = "enable"
}

variable "multicast_group_members" {
  type        = map(string)
  description = "Required: The ENIs to add to the group ip address"
/*
  default = {
    eni-11111111111111111 = "224.0.0.10"
    eni-22222222222222222 = "224.0.0.10"
    eni-33333333333333333 = "224.0.0.10"
    eni-aaaaaaaaaaaaaaaaa = "224.0.0.11"
    eni-bbbbbbbbbbbbbbbbb = "224.0.0.11"
    eni-ccccccccccccccccc = "224.0.0.11"
  }
*/
}
