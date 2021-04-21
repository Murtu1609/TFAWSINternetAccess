
resource "aws_internet_gateway" "gw" {
    
  vpc_id = var.vpc-id
}

resource "aws_subnet" "public_subnet"{
    
    vpc_id = var.vpc-id
    cidr_block = var.public-subnet-cidr
    availability_zone = var.public-subnet-az
    tags= {
        Name = var.public-subnet-name
    }
}

resource "aws_route_table" "rt" {
    
  vpc_id = var.vpc-id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }
}

resource "aws_route_table_association" "a" {
   
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.rt.id
}

resource "aws_eip" "public_ip" {
  
}

resource "aws_nat_gateway" "nat_gw" {
    
  allocation_id = aws_eip.public_ip.id
  subnet_id     = aws_subnet.public_subnet.id
}

data "aws_vpc" "vpc" {
  id = var.vpc-id
}

resource "aws_route" "r" {
  route_table_id              = data.aws_vpc.vpc.main_route_table_id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id      = aws_nat_gateway.nat_gw.id
}