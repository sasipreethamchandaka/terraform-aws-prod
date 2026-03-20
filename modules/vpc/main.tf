############################################
# 📌 DATA SOURCE (AZs)
############################################
data "aws_availability_zones" "available" {}

############################################
# 📌 VPC
############################################
resource "aws_vpc" "main" {
  cidr_block = var.cidr_block

  tags = {
    Name = "main-vpc"
  }
}

############################################
# 📌 INTERNET GATEWAY
############################################
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id
}

############################################
# 📌 PUBLIC SUBNETS
############################################
resource "aws_subnet" "public" {
  count = var.public_subnet_count

  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.${count.index}.0/24"
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  map_public_ip_on_launch = true
}

############################################
# 📌 PRIVATE SUBNETS
############################################
resource "aws_subnet" "private" {
  count = var.private_subnet_count

  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.${count.index + 2}.0/24"
  availability_zone = data.aws_availability_zones.available.names[count.index]
}

############################################
# 📌 ELASTIC IP FOR NAT
############################################
resource "aws_eip" "nat" {
  domain = "vpc"
}

############################################
# 📌 NAT GATEWAY (IN PUBLIC SUBNET)
############################################
resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public[0].id

  depends_on = [aws_internet_gateway.igw]
}

############################################
# 📌 PUBLIC ROUTE TABLE
############################################
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id
}

############################################
# 📌 PUBLIC ROUTE → INTERNET
############################################
resource "aws_route" "public_internet" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}

############################################
# 📌 ASSOCIATE PUBLIC SUBNETS
############################################
resource "aws_route_table_association" "public" {
  count = var.public_subnet_count

  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}

############################################
# 📌 PRIVATE ROUTE TABLE
############################################
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id
}

############################################
# 📌 PRIVATE ROUTE → NAT GATEWAY
############################################
resource "aws_route" "private_nat" {
  route_table_id         = aws_route_table.private.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat.id
}

############################################
# 📌 ASSOCIATE PRIVATE SUBNETS
############################################
resource "aws_route_table_association" "private" {
  count = var.private_subnet_count

  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private.id
}
