variable "vpc_cidr" {
  
}
variable "env" {
  
}
variable "public_subnets" {
type = map(string)
default = {

}
}
variable "from_port" {
  
}
variable "to_port" {
  
}
variable "public_rt_cidr_block" {
  
}
variable "private_subnets" {
  type = map(string)
  default = {
    
  }
  
}
variable "alb_type_internal" {
  type = map(string)
  default = {
    
  }
}
variable "lb_cidr_block" {
  
}
variable "alb_type" {
  
}
variable "internal" {
  
}