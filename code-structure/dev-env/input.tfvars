env = "dev" 
vpc_cidr = "10.0.0.0/16"
public_subnets = ["10.0.1.0/24","10.0.2.0/24"]
public_rt_cidr_block = "0.0.0.0/0"
from_port = [443,80,22]
to_port = [443,80,22]
private_subnets = ["10.0.3.0/24","10.0.4.0/24"]
alb_type_internal = {
    false: "public",
    true: "private"
}
SUBNETS =""
vpc_id = ""
public_lb_azs = ["us-east-1c","us-east-1d"]
private_lb_azs = ["us-east-1a","us-east-1b"]
alb_type = ""
internal = ""
instance_type = "t2.micro"
components = ["frontend","backend"]
image_id = ""
terraform_controller_instance_cidr="172.31.45.11/32"