output "public_subnets" {
  value = aws_subnet.public_subnets.*.id
}
output "vpc_CIDR_ID" {
  value = aws_vpc.vpc.id
}