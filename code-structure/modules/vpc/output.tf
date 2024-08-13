output "pb_subnets" {
  value = values(resource.aws_subnet.public_subnet)[*].id
}
output "vpc_CIDR_ID" {
  value = aws_vpc.vpc.id
}
output "pvt_subnets" {
  value = values(resource.aws_subnet.private_subnets)[*].id
}