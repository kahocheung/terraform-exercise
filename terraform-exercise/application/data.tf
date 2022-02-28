data "aws_subnet" "public" {
  count = length(var.azs)

  vpc_id = data.aws_vpc.main.id

  filter {
    name   = "tag:accessible"
    values = ["public"]
  }

  filter {
    name   = "tag:Name"
    values = ["test-public-${var.azs[count.index]}"]
  }
}

data "aws_subnet" "private" {
  count = length(var.azs)

  vpc_id = data.aws_vpc.main.id

  filter {
    name   = "tag:accessible"
    values = ["private"]
  }

  filter {
    name   = "tag:Name"
    values = ["test-private-${var.azs[count.index]}"]
  }
}

data "aws_ami" "amazon2" {
  most_recent = true

  filter {
    name = "name"
    values = ["amzn2-ami-hvm-*-x86_64-ebs"]
  }
  owners = ["amazon"]
}
