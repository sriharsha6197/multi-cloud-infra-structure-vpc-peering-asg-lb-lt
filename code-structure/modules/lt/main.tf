resource "aws_security_group" "lt_sg" {
  for_each = zipmap(range(length(var.components)),var.components)
  name = "${var.env}-lt-sg-${each.value}"
  description = "${var.env}-lt-sg"
  vpc_id = var.vpc_id
  tags = {
    Name = "${var.env}-lt-sg-${each.value}"
  }
}
resource "aws_vpc_security_group_ingress_rule" "ingress_sg" {
  security_group_id = aws_security_group.lt_sg[each.key].id
  cidr_ipv4 = var.vpc_cidr
  for_each = zipmap(range(length(var.from_port)), var.from_port)
  from_port = each.value
  to_port = each.value
  ip_protocol = "tcp"
}
resource "aws_vpc_security_group_ingress_rule" "ingress_rule" {
  for_each = zipmap(range(length(var.components)),var.components)
  security_group_id = aws_security_group.lt_sg[each.key].id
  cidr_ipv4 = var.terraform_controller_instance_cidr
  from_port = 22
  to_port = 22
  ip_protocol = "tcp"
}
resource "aws_vpc_security_group_egress_rule" "egress_sg" {
  for_each = zipmap(range(length(var.components)),var.components)
  security_group_id = aws_security_group.lt_sg[each.key].id
  cidr_ipv4 = var.public_rt_cidr_block
  ip_protocol = "-1"
}
resource "aws_iam_role" "lt_servers_role" {
  for_each = zipmap(range(length(var.components)),var.components)
  name = "${var.env}-${each.value}-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })
  tags = {
    tag-key = "${var.env}-${each.value}-role"
  }
}
resource "aws_iam_role_policy" "role_policy" {
  for_each = zipmap(range(length(var.components)),var.components)
  name = "${var.env}-${each.value}-role-policy"
  role = aws_iam_role.lt_servers_role[each.key].id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "*"
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
}
resource "aws_iam_instance_profile" "test_profile" {
  for_each = zipmap(range(length(var.components)),var.components)
  name = "${var.env}-instance-profile-${each.value}"
  role = aws_iam_role.lt_servers_role[each.key].name
}

resource "aws_launch_template" "lt" {
  for_each = zipmap(range(length(var.components)),var.components)
  name = "${var.env}-lt-${each.value}"
  image_id = var.image_id
  instance_type = var.instance_type
  vpc_security_group_ids = [aws_security_group.lt_sg[each.key].id]
  user_data = base64encode(templatefile("${path.module}/app_config.sh",{
    server_component=var.components
  }))
  iam_instance_profile {
    name = aws_iam_instance_profile.test_profile[each.key].name
  }
  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "${var.env}-server-${each.value}"
    }
  }
}

resource "aws_autoscaling_group" "bar" {
  for_each = zipmap(range(length(var.components)),var.components)
  desired_capacity   = 1
  max_size           = 1
  min_size           = 1
  vpc_zone_identifier = var.private_subnets
  launch_template {
    id      = aws_launch_template.lt[each.key].id
    version = "$Latest"
  }
}