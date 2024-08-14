resource "aws_security_group" "lt_sg" {
  name = "${var.env}-lt-sg-${var.components}"
  description = "${var.env}-lt-sg"
  vpc_id = var.vpc_id
  tags = {
    Name = "${var.env}-lt-sg-${var.components}"
  }
}
resource "aws_vpc_security_group_ingress_rule" "ingress_sg" {
  security_group_id = aws_security_group.lt_sg.id
  cidr_ipv4 = var.vpc_cidr
  for_each = zipmap(range(length(var.from_port)), var.from_port)
  from_port = each.value
  to_port = each.value
  ip_protocol = "tcp"
}
resource "aws_vpc_security_group_egress_rule" "egress_sg" {
  security_group_id = aws_security_group.lt_sg.id
  cidr_ipv4 = var.public_rt_cidr_block
  ip_protocol = "-1"
}

resource "aws_launch_template" "lt" {
  name = "${var.env}-lt-${var.components}"
  image_id = var.image_id
  instance_type = var.instance_type
  vpc_security_group_ids = [aws_security_group.lt_sg.id]

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "${var.env}-lt-${var.components}"
    }
  }
}

resource "aws_autoscaling_group" "bar" {
  desired_capacity   = 1
  max_size           = 1
  min_size           = 1
  vpc_zone_identifier = var.private_subnets
  launch_template {
    id      = aws_launch_template.lt.id
    version = "$Latest"
  }
}