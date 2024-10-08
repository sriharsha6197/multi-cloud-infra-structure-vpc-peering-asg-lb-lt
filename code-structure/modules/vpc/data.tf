data "aws_vpc" "default_vpc" {
  id = var.default_vpc
}
variable "default_vpc" {
  default = "vpc-019eb600d42615e77"
}
data "aws_route_table" "default" {
  vpc_id = data.aws_vpc.default_vpc.id
}
data "aws_ami" "ami" {
  most_recent = true
  name_regex = "Centos-8-DevOps-Practice"
  owners = [973714476881]
}