output "public_subnets" {
  value = aws_subnet.public_subnets.*.subnet_id
}