resource "aws_subnet" "public" {
  count = 3
  vpc_id = var.vpc_id
  cidr_block = cidrsubnet(var.vpc_cidr, 8, count.index)
  availability_zone = element(["us-east-1a", "us-east-1b", "us-east-1c"], count.index)
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.application_name}-public-${count.index + 1}"
  }
}

resource "aws_subnet" "private" {
  count = 3
  vpc_id = var.vpc_id
  cidr_block = cidrsubnet(var.vpc_cidr, 8, count.index + 3)
  availability_zone = element(["us-east-1a", "us-east-1b", "us-east-1c"], count.index)

  tags = {
    Name = "${var.application_name}-private-${count.index + 1}"
  }
}
