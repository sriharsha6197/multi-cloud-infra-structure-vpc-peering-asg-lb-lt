env = "dev" 
vpc_cidr = "10.0.0.0/16"
public_subnets = ["10.0.1.0/24","10.0.2.0/24"]
public_rt_cidr_block = "0.0.0.0"
from_port = [80,22,443]
to_port = [80,22,443]
private_subnets = ["10.0.3.0/24","10.0.4.0/24"]