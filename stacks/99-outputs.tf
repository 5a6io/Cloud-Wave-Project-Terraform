output "dr_vpc_id" {
  value       = try(module.dr_vpc[0].vpc_id, null)
  description = "도쿄 DR VPC ID"
}

output "dr_public_subnet_ids" {
  value       = try(module.dr_subnets[0].public_subnets, null)
  description = "도쿄 DR 퍼블릭 서브넷"
}

output "dr_private_subnet_ids" {
  value       = try(module.dr_subnets[0].private_subnets, null)
  description = "도쿄 DR 프라이빗 서브넷"
}
