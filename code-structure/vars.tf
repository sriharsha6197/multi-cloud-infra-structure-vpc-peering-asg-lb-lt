variable "vpc_cidr" {
  
}
variable "env" {
  
}
variable "public_subnets" {
}
variable "from_port" {
  
}
variable "to_port" {
  
}
variable "public_rt_cidr_block" {
  
}
variable "private_subnets" {
}
variable "vpc_id" {
  
}
variable "SUBNETS" {
  
}
variable "alb_type_internal" {
  type = map(string)
  default = {
    
  }
}
variable "public_lb_azs" {
  type = map(string)
  default = {
    
  }
}