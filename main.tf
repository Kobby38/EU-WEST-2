# Configure the AWS Provider
provider "aws" {
  region = "eu-west-2"
}
#creating networking for project
resource "aws_vpc" "vpc-eu-west-2" {
  cidr_block       = var.cidr-for-vpc
  instance_tenancy = "default"
  enable_dns_hostnames = true
  enable_dns_support = true
  tags = {
    Name = "vpc-eu-west-2"
  }
}

#public subnet
resource "aws_subnet" "prod-pub-sub1" {
  vpc_id     = aws_vpc.vpc-eu-west-2.id
  cidr_block = var.cidr-for-public-subnet-1
  availability_zone = var.AZ-1
  tags = {
    Name = "prod-pub-sub1"
  }
}

resource "aws_subnet" "prod-pub-sub2" {
  vpc_id     = aws_vpc.vpc-eu-west-2.id
  cidr_block = var.cidr-for-public-subnet-2
  availability_zone = var.AZ-2
  tags = {
    Name = "prod-pub-sub2"
  }
}

resource "aws_subnet" "prod-pub-sub3" {
  vpc_id     = aws_vpc.vpc-eu-west-2.id
  cidr_block = var.cidr-for-public-subnet-3
  availability_zone = var.AZ-3
  tags = {
    Name = "prod-pub-sub3"
  }
}

#private subnet
resource "aws_subnet" "prod-priv-sub1" {
  vpc_id     = aws_vpc.vpc-eu-west-2.id
  cidr_block = var.cidr-for-private-subnet-1
  availability_zone = var.AZ-4
    tags = {
    Name = "prod-priv-sub1"
  }
}

resource "aws_subnet" "prod-priv-sub2" {
  vpc_id     = aws_vpc.vpc-eu-west-2.id
  cidr_block = var.cidr-for-private-subnet-2
  availability_zone = var.AZ-5
  tags = {
    Name = "prod-priv-sub2"
  }
}

# route table
resource "aws_route_table" "prod-pub-route-table" {
  vpc_id = aws_vpc.vpc-eu-west-2.id

  tags = {
    Name = "prod-pub-route-table"
  }
}

resource "aws_route_table" "prod-priv-route-table" {
  vpc_id = aws_vpc.vpc-eu-west-2.id

  tags = {
    Name = "prod-priv-route-table"
  }
}

# route association public
resource "aws_route_table_association" "public-route-table-association-1" {
  subnet_id      = aws_subnet.prod-pub-sub1.id
  route_table_id = aws_route_table.prod-pub-route-table.id
}

resource "aws_route_table_association" "public-route-table-association-2" {
  subnet_id      = aws_subnet.prod-pub-sub2.id
  route_table_id = aws_route_table.prod-pub-route-table.id
  }

resource "aws_route_table_association" "public-route-table-association-3" {
  subnet_id      = aws_subnet.prod-pub-sub3.id
  route_table_id = aws_route_table.prod-pub-route-table.id  
   }

   # route association private
resource "aws_route_table_association" "private-route-table-association-1" {
  subnet_id      = aws_subnet.prod-priv-sub1.id
  route_table_id = aws_route_table.prod-priv-route-table.id
}

resource "aws_route_table_association" "private-route-table-association-2" {
  subnet_id      = aws_subnet.prod-priv-sub2.id
  route_table_id = aws_route_table.prod-priv-route-table.id
}

# internet gateway

resource "aws_internet_gateway" "Prod-igw" {
  vpc_id = aws_vpc.vpc-eu-west-2.id

  tags = {
    Name = "Prod-igw"
  }
}

# aws route
resource "aws_route" "Prod-igw-association" {
  route_table_id            = aws_route_table.prod-pub-route-table.id
  gateway_id                = aws_internet_gateway.Prod-igw.id  
  destination_cidr_block    = var.internet-gateway-association
  }

# Nat Gateway for internet through the public subnet

resource "aws_eip" "EIP_for_NG" {
  vpc                       = true
  associate_with_private_ip = var.elastic-ip
  }

  resource "aws_nat_gateway" "Prod-Nat-gateway" {
  allocation_id = aws_eip.EIP_for_NG.id
  subnet_id     = aws_subnet.prod-pub-sub1.id
 }

 # Route NAT Gateway with private Route table
resource "aws_route" "Prod-nat-association" {
  route_table_id         = aws_route_table.prod-priv-route-table.id
  nat_gateway_id         = aws_nat_gateway.Prod-Nat-gateway.id
  destination_cidr_block = var.nat-gateway-destination-cidr-block
}