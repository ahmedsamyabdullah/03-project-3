terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# Configure The AWS provider
provider "aws" {
  region = var.aws_region
}

# Create VPC resource
resource "aws_vpc" "main_vpc" {
  cidr_block = var.vpc_cidr

  tags = {
    "Name" = "main_vpc" # This Name will display on AWS Console
  }

}

# Create internet-gateway (IGW)
resource "aws_internet_gateway" "main_igw" {
  vpc_id  = aws_vpc.main_vpc.id

  tags = {
    "Name"  = "Main_IGW"
  }
}

# Create Public Subnet
resource "aws_subnet" "public_subnet" {
  vpc_id            = aws_vpc.main_vpc.id
  cidr_block        = var.public_subnet_cidr
  map_public_ip_on_launch = true              # This enables auto-assign public ip
  availability_zone = var.public_subnet_az

  tags = {
    "Name" = "Public_Subnet"
  }
}

# Create Public Route Table (rt)
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.main_vpc.id
  route {
    cidr_block = var.public_rt_cidr
    gateway_id = aws_internet_gateway.main_igw.id  
  }


  tags = {
    Name = "Public_Route_Table"
  }
}

# Associate Public subnet with public Route table
resource "aws_route_table_association" "public_subnet_rt" {
  subnet_id = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_rt.id
}

# Create Main SG (Security Group) that allows http,https
resource "aws_security_group" "main_sg" {
  name = "main_sg"
  description = "Allow HTTP & HTTPS traffic"
  vpc_id = aws_vpc.main_vpc.id

  
  ingress {                   # Allow HTTP port 80 from anywhere
    from_port = 80  
    to_port = 80 
    protocol = "tcp"
    cidr_blocks = var.allow_cidr
  }

  
  ingress {                     # Allow HTTPS port 443 from anywhere
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = var.allow_cidr
  }

  ingress {                     # Allow SSH port 22 from anywhere
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = var.allow_cidr
  }

  
  egress {                      # Allow All outbound traffic
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = var.allow_cidr
  }

  tags = {
    "Name" = "Main_SG"
  }

}

# Create Amazon Linux EC2 instance - Main VM
resource "aws_instance" "main_vm" {
  ami           = var.main_vm_ami
  instance_type = var.main_vm_type
  subnet_id = aws_subnet.public_subnet.id
  vpc_security_group_ids = [ aws_security_group.main_sg.id ]
  associate_public_ip_address = true  
  key_name  = var.key_name

  tags = {
    Name = "Main VM"
  }

}