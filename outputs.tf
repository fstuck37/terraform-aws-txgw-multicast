output "arn" {
  value = aws_ec2_transit_gateway.txgw.arn
}

output "association_default_route_table_id" {
  value = aws_ec2_transit_gateway.txgw.association_default_route_table_id
}

output "id" {
  value = aws_ec2_transit_gateway.txgw.id
}

output "owner_id" {
  value = aws_ec2_transit_gateway.txgw.owner_id
}

output "propagation_default_route_table_id" {
  value = aws_ec2_transit_gateway.txgw.propagation_default_route_table_id
}
