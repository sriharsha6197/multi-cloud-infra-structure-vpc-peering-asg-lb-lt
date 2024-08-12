output "public_subnet" {
  value = aws_subnet.public_subnets[*].subnet_id
}
output "vpc_CIDR_ID" {
  value = aws_vpc.vpc.id
}