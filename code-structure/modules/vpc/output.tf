output "vpc_ID" {
  value = aws_vpc.vpc.id
}
output "PUBLIC_SUBNETS" {
  value = values(aws_subnet.public_subnet)[*].id
}
output "PRIVATE_SUBNETS" {
  value = values(aws_subnet.private_subnets)[*].id
}
output "AZS" {
  value = values(var.public_lb_azs)[*]
}