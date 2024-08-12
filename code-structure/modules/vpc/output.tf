output "subnet_ids" {
  value = values(resource.aws_subnet.public_subnet)[*].id
}
output "vpc_CIDR_ID" {
  value = aws_vpc.vpc.id
}