output "private_route_table_ids" {
  value = aws_route_table.rtb_pri[*].id
}

output "public_route_table_ids" {
  value = aws_route_table.rtb_pub[*].id
}