module "rds" {
  source  = "terraform-aws-modules/rds/aws"
  version = "4.1.3"

  identifier = var.rds["identifier"]

  family = "mysql5.7"

  engine = var.rds["engine"]
  engine_version = var.rds["auto_minor_version_upgrade"] ? var.rds["major_engine_version"] : var.rds["engine_version"]
  instance_class = var.rds["instance_class"]
  storage_encrypted = true
  allocated_storage = var.rds["allocated_storage"]

  db_subnet_group_name   = "test"
  create_db_subnet_group = true
  subnet_ids = data.aws_subnet.private.*.id

  username = var.rds_username
  password = var.rds_password
  port     = 3306

  vpc_security_group_ids = [aws_security_group.rds.id]

  multi_az = false
}

resource "aws_security_group" "rds" {
  name = "${local.name}-rds"

  # allow all egress
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }
}
