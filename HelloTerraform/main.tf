// Create the vpc
resource "aws_vpc" "minhquang-vpc" {
  cidr_block = var.cidrvpc

  tags = var.tags
}

//create the public subnet
resource "aws_subnet" "public" {

  vpc_id            = aws_vpc.minhquang-vpc.id
  count             = var.az_count
  cidr_block        = cidrsubnet(aws_vpc.minhquang-vpc.cidr_block, 8, count.index)
  availability_zone = data.aws_availability_zones.available.names[count.index]
  tags              = merge(var.tags, { Name = "${var.vpc_name}-public-subnet-${count.index}" })
}

//create internet gateway
resource "aws_internet_gateway" "minhquang-igw" {
  vpc_id = aws_vpc.minhquang-vpc.id
  tags   = merge(var.tags, { Name = "${var.vpc_name}-igw" })
}

//create route
resource "aws_route" "minhquang-route" {
  route_table_id         = aws_vpc.minhquang-vpc.default_route_table_id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.minhquang-igw.id
}

// associate the public subnet with to main route table with igw
resource "aws_route_table_association" "minhquang-public-subnet-rtb" {
  count          = var.az_count
  subnet_id      = element(aws_subnet.public[*].id, count.index)
  route_table_id = aws_vpc.minhquang-vpc.default_route_table_id
}

// create the private subnet
resource "aws_subnet" "private" {
  vpc_id            = aws_vpc.minhquang-vpc.id
  count             = var.az_count
  cidr_block        = cidrsubnet(aws_vpc.minhquang-vpc.cidr_block, 8, count.index + var.az_count)
  availability_zone = data.aws_availability_zones.available.names[count.index]
  tags              = merge(var.tags, { Name = "${var.vpc_name}-private-subnet-${count.index}" })
}

// Create the natgate way
resource "aws_eip" "ngweip" {
  count = var.az_count
  tags  = merge(var.tags, { Name = "${var.vpc_name}-ngw-eip-${count.index}" })
}

resource "aws_nat_gateway" "ngw" {
  count         = var.az_count
  subnet_id     = element(aws_subnet.private[*].id, count.index)
  allocation_id = element(aws_eip.ngweip[*].id, count.index)
  tags          = merge(var.tags, { Name = "${var.vpc_name}-ngw-gateway-${count.index}" })
}

// create the route table for private subnet
resource "aws_route_table" "minhquang-private-rtb" {
  count  = var.az_count
  vpc_id = aws_vpc.minhquang-vpc.id
  tags   = merge(var.tags, { Name = "${var.vpc_name}-private-rtb" })

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = element(aws_nat_gateway.ngw.*.id, count.index)
  }
}

// Assosiate the private subnet to the private route table
resource "aws_route_table_association" "minhquang-private-subnet-rtb" {
  count          = var.az_count
  subnet_id      = element(aws_subnet.private[*].id, count.index)
  route_table_id = element(aws_route_table.minhquang-private-rtb[*].id, count.index)
}

