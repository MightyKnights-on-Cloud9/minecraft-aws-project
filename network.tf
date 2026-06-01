data "aws_availability_zones" "available" {}

resource "aws_vpc" "minecraft_vpc" {
  cidr_block           = var.vpc_cidr_block
  enable_dns_support   = true # Added: Allows AWS internal DNS resolution
  enable_dns_hostnames = true # Added: Assigns a public DNS hostname to your EC2 instance

  tags = {
    Name = "minecraft-vpc"
  }
}

resource "aws_subnet" "minecraft_subnet" {
  vpc_id                  = aws_vpc.minecraft_vpc.id
  cidr_block              = var.subnet
  availability_zone       = data.aws_availability_zones.available.names[0]
  map_public_ip_on_launch = true # Required for your server to be reachable

  tags = {
    Name = "minecraft-subnet"
  }
}

resource "aws_internet_gateway" "minecraft_igw" {
  vpc_id = aws_vpc.minecraft_vpc.id

  tags = {
    Name = "minecraft-igw"
  }
}

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.minecraft_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.minecraft_igw.id
  }

  tags = {
    Name = "minecraft-public-rt"
  }
}

resource "aws_route_table_association" "public_subnet_assoc" {
  subnet_id      = aws_subnet.minecraft_subnet.id
  route_table_id = aws_route_table.public_rt.id

}