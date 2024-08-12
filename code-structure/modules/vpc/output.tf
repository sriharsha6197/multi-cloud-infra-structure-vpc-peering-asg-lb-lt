output "public_subnets" {
  value = aws_subnet.public_subnets.*.id
}
output "vpc_CIDR" {
  value = var.vpc_cidr
}
output "pb_rt_cidr_block" {
  value = var.public_rt_cidr_block
}
output "from_PORT" {
  value = var.from_port.*
}
output "to_PORT" {
  value = var.to_port.*
}