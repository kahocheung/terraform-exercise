resource "aws_security_group" "alb" {
  name        = "${var.prefix}-alb"
  description = "ALB security group"
  vpc_id      = data.aws_vpc.main.id

  # allow all egress
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }

}

resource "aws_security_group" "ec2" {
  name        = "${var.prefix}-ec2"
  description = "EC2 security group"
  vpc_id      = data.aws_vpc.main.id

  # allow all egress
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }

}

resource "aws_lb" "alb" {
  name = "${var.prefix}-alb"

  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb.id]

}

resource "aws_alb_target_group" "main" {
  name     = "${local.name}-tg"
  vpc_id   = data.aws_vpc.main.id
  port     = 80
  protocol = "HTTP"

  deregistration_delay = 20

  lifecycle {
    create_before_destroy = true
  }

  health_check {
    path                = "/"
    matcher             = "200"
    timeout             = 10
    interval            = 15
    healthy_threshold   = 2
    unhealthy_threshold = 4
  }
}

resource "aws_launch_configuration" "main" {
  name_prefix   = "${local.name}-"
  key_name      = "interview-test"
  image_id      = data.aws_ami.amazon-2.id
  ebs_optimized = false
  instance_type = var.ec2["instance_type"]

  iam_instance_profile = aws_iam_instance_profile.iam_profile.name

  security_groups = [
    aws_security_group.ec2.id
  ]

  associate_public_ip_address = false

  root_block_device {
    encrypted   = false
    volume_size = 8
    volume_type = "gp2"
  }

  lifecycle {
    ignore_changes = [
      name,
      iam_instance_profile,
    ]
    create_before_destroy = true
  }
}

data "template_file" "main" {
  template   = file("templates/test-cloudinit.tpl")

  vars = {
    DBEndpoint       = module.rds.db_instance_endpoint
    TestMysqlRDS     = "test_db"
  }
}

