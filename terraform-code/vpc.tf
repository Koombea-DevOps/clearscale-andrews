resource "aws_vpc" "main" {
  cidr_block = "${var.vpc_cidr_block}"

  tags = {
    Name = "${terraform.workspace}-${var.project_name}"
  }
}

resource "aws_subnet" "public" {
  count                   = "${length(var.public_subnets)}"
  vpc_id                  = "${aws_vpc.main.id}"
  cidr_block              = "${var.public_subnets[count.index]}"
  availability_zone       = "${data.aws_availability_zones.available.names[count.index]}"
  map_public_ip_on_launch = true

  tags {
    Name = "${terraform.workspace}-${var.project_name}-public-${data.aws_availability_zones.available.names[count.index]}"
  }
}

resource "aws_subnet" "private" {
  count                   = "${length(var.public_subnets)}"
  vpc_id                  = "${aws_vpc.main.id}"
  cidr_block              = "${var.private_subnets[count.index]}"
  availability_zone       = "${data.aws_availability_zones.available.names[count.index]}"

  tags {
    Name = "${terraform.workspace}-${var.project_name}-private-${data.aws_availability_zones.available.names[count.index]}"
  }
}
