resource "aws_security_group" "security_group_lb" {
  name = "${var.env}-${var.alb_type}-sg"
  description = "allow-all-sg"
  vpc_id = var.vpc_id
  tags = {
    Name = "${var.env}-${var.alb_type}-sg"
  }
}
resource "aws_vpc_security_group_ingress_rule" "ingress_sg" {
  security_group_id = aws_security_group.security_group_lb.id
  cidr_ipv4 = var.lb_cidr_block
  for_each = zipmap(range(length(var.from_port)), var.from_port)
  from_port = each.value
  to_port = each.value
  ip_protocol = "tcp"
}
resource "aws_vpc_security_group_egress_rule" "egress_sg" {
  security_group_id = aws_security_group.security_group_lb.id
  cidr_ipv4 = var.lb_cidr_block
  ip_protocol = "-1"
}

resource "aws_lb" "test" {
  name               = "${var.env}-${var.alb_type}"
  internal           = var.internal
  load_balancer_type = "application"
  security_groups    = [aws_security_group.security_group_lb.id]
  subnets            = var.public_subnets
  tags = {
    Environment = "${var.env}-${var.alb_type}"
  }
}