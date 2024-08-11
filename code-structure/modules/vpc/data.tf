data "aws_vpc" "default_vpc" {
  id = var.default_vpc
}
variable "default_vpc" {
  default = "vpc-0683db6837f2e22a0"
}
data "aws_route_table" "default" {
  vpc_id = data.aws_vpc.default_vpc.id
}