AWS Transit Gateway
=============

![AWS VPC](docs/images/aws-vpc.png)

This module deploys an AWS VPC and all necessary components to prepare an environment for connectivity to the Internet and a Direct Connect circuit.

The goal of this project is to provide a streamlined, simple Terraform script to deploy and start running a network in AWS.


Example
------------
```
module "txgw1" {
  source               = "git::https://github.com/fstuck37/terraform-aws-txgw.git"
  region               = "us-east-1"
  amazon_side_asn      = "64512"
  description          = "Transit Gateway userd to connect all VPC together"
  account_associations = var.account_associations
  tags                 = var.tags
  
  tx_peerlinks = {
    txgw-uswest2 = {
      peer_region = "us-west-2"
      peer_account_id = module.txgw2.owner_id
      peer_transit_gateway_id = module.txgw2.id
    }
  }
  
}

module "txgw2" {
  source               = "git::https://github.com/fstuck37/terraform-aws-txgw.git"
  region               = "us-west-2"
  amazon_side_asn      = "65512"
  description          = "Transit Gateway userd to connect all VPC together"
  account_associations = var.account_associations
  tags                 = var.tags

  tx_peerlink_acceptors = {
    txgw-useast1 = module.txgw1.txgw_peering_id["txgw-uswest2"]
  }
}

variable "tags" {
  type = map(string)
  default = {
    dept = "Development"
    Billing = "12345"
    Contact = "F. Stuck"
    Environment = "POC"
    Notes  = "This is a test TXGW"
  }
}

variable "account_associations" {
  type = map(string)
  default = {
    account1 = "123456789012"
    account2 = "112233445566"
    account3 = "778899001122"
  }
}
```

Argument Reference
------------
* **Settings**
   * **region** - Required : The AWS Region to deploy the Transit Gateway to. For example us-east-1
   * **amazon_side_asn** - Optional : Private Autonomous System Number (ASN) for the Amazon side of a BGP session. The range is 64512 to 65534 for 16-bit ASNs and 4200000000 to 4294967294 for 32-bit ASNs. Default value: 64512.
   * **auto_accept_shared_attachments** - Optional: Whether resource attachment requests are automatically accepted. Valid values: disable, enable. Default value: enable.
   * **default_route_table_association** - Optional: Whether resource attachments are automatically associated with the default association route table. Valid values: disable, enable. Default value: enable.
   * **default_route_table_propagation** - Optional: Whether resource attachments automatically propagate routes to the default propagation route table. Valid values: disable, enable. Default value: enable.
   * **description** - Optional: Description of the EC2 Transit Gateway. The default is blank.
   * **dns_support** - Optional: Whether DNS support is enabled. Valid values: disable, enable. Default value: enable.
   * **vpn_ecmp_support** - Optional: Whether VPN Equal Cost Multipath Protocol support is enabled. Valid values: disable, enable. Default value: enable.
   * **account_associations** - Optional : A Map of account name, account number to share the transit gateway
   * **tags** - Optional : A map of tags to assign to the resource.  
   * **tx_peerlinks** - Optional : A Map or Maps of Transit Gateway Peer links name = peer_account_id, peer_region, peer_transit_gateway_id
   * **tx_peerlink_acceptors** - Optional : A Map of Transit Gateway Peer links name = transit_gateway_attachment_id

Output Reference
------------
  * **arn** - EC2 Transit Gateway Amazon Resource Name (ARN)
  * **association_default_route_table_id** - Identifier of the default association route table
  * **id** - EC2 Transit Gateway identifier
  * **owner_id** - Identifier of the AWS account that owns the EC2 Transit Gateway
  * **propagation_default_route_table_id** - Identifier of the default propagation route table.
  * **txgw_peering_id**  - Map of Transit Gateway peering IDs. Key is the key from tx_peerlinks.
  