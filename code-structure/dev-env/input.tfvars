env = "dev" 
vpc_cidr = "10.0.0.0/16"
public_subnets = ["10.0.1.0/24","10.0.2.0/24"]
public_rt_cidr_block = "0.0.0.0/0"
from_port = [443,80,22]
to_port = [443,80,22]
private_subnets = ["10.0.3.0/24","10.0.4.0/24"]
alb_type = [""]
internal = [""]
alb_type_internal = {
    internal_value = {
        key1: "false",
        key2: "true"
    },
    type_value ={
        value1: "public",
        value2: "private"
    },
    subnets = {
        public_subnets = {
            value1: "10.0.1.0/24",
            value2: "10.0.2.0/24"
        },
        private_subnets = {
            value1: "10.0.3.0/24",
            value2: "10.0.4.0/24"
        }
    }
}
lb_cidr_block = "0.0.0.0/0"