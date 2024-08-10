resource "aws_vpc" "vpc" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = "${var.env}-vpc"
  }
}
resource "aws_subnet" "public_subnets" {
  for_each = var.public_subnets
  vpc_id     = aws_vpc.vpc.id
  cidr_block = each.value

  tags = {
    Name = "${var.env}-public-subnet-${each + 1}"
  }
}