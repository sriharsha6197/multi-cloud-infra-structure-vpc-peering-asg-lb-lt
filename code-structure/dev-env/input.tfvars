env = "dev" 
vpc_cidr = "10.0.0.0/16"
public_subnets = {
    us-east-1c: "10.0.1.0/24",
    us-east-1d: "10.0.2.0/24"
}
public_rt_cidr_block = "0.0.0.0/0"
from_port = [443,80,22]
to_port = [443,80,22]
private_subnets = {
    us-east-1a: "10.0.3.0/24",
    us-east-1b: "10.0.4.0/24"
}
alb_type = [""]
internal = [""]
alb_type_internal = {
    false : "public",
    true: "private",
}
lb_cidr_block = "0.0.0.0/0"