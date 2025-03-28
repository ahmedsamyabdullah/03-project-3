###########################################################################################################################
# in this file we will only define variables name but not use (default), the values will pass through variables.tfvars file
#############################################################################################################################

variable "aws_region" {
  description = "AWS Region where the resources will be created"
  type        = string
}

# Define CIDR Block for AWS VPC
variable "vpc_cidr" {
  description = "CIDR Block for VPC"
  type        = string
}

# Define CIDR Block For public_subnet
variable "public_subnet_cidr" {
  description = "CIDR Block for public_subnet within main_vpc"
  type        = string
}

# Define AZ for public_subnet
variable "public_subnet_az" {
  description = "Availability zone for public_subnet"
  type        = string
}

# Define public route table cidr_block destination for public subnet
variable "public_rt_cidr" {
  description = " public route table cidr_block destination for public subnet"
  type        = string
}

# Define Allow CIDR_BLOCKS that allows all traffic from and to anywhere
variable "allow_cidr" {
  description = "CIDR_BLOCKS that allows all traffic from and to anywhere ip add used in SG ingress & egress"
  type = list(string)
}

# Define ami for main_vm ec2 instance
variable "main_vm_ami" {
  description = "AMI for amazon linux for my main_vm"
  type = string
}

# Define instance_type for main_vm ec2 instance
variable "main_vm_type" {
  description = "Instance type for main_vm EC2 instance"
  type = string
}

# Define Key_name for main_vm key pair
variable "key_name"{
  description = "key_name which gets from key pairs for main_vm"
  type = string
}