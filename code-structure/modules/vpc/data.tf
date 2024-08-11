data "aws_ami" "ami" {
  most_recent = true
  owners = [891377109045]
}
data "aws_vpc" "default_vpc" {
  id = var.default_vpc
}
variable "default_vpc" {
  default = "vpc-0683db6837f2e22a0"
}