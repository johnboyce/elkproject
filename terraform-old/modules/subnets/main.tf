resource "aws_subnet" "public" {
  count = 3
  vpc_id = var.vpc_id
  cidr_block = cidrsubnet(var.vpc_cidr, 8, count.index)
  availability_zone = element(["us-east-1a", "us-east-1b", "us-east-1c"], count.index)
  map_public_ip_on_launch = false

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
resource "aws_route_table" "public" {
  vpc_id = var.vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = var.internet_gateway_id
  }

  tags = {
    Name = "${var.application_name}-public-rt"
  }
}

resource "aws_route_table_association" "public" {
  count          = length(aws_subnet.public)
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}
