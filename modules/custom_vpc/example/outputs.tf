output "vpc_id" {
  description = "ID of the VPC."
  value       = module.custom_vpc.vpc_id
}

output "vpc_arn" {
  description = "Amazon Resource Name (ARN) of the VPC."
  value       = module.custom_vpc.vpc_arn
}

output "public_subnet_ids" {
  description = "IDs of the public subnets."
  value       = module.custom_vpc.public_subnet_ids
}

output "private_subnet_ids" {
  description = "IDs of the private subnets."
  value       = module.custom_vpc.private_subnet_ids
}

output "internet_gateway_id" {
  description = "ID of the internet gateway attached to the VPC."
  value       = module.custom_vpc.internet_gateway_id
}

output "public_route_table_id" {
  description = "ID of the public route table associated with the public subnet."
  value       = module.custom_vpc.public_route_table_id
}
