# Define Data source to get Lates AMI for ec2 instance main_vm Amazon Linux 2023
data "aws_ami" "ami_main_vm" {
  owners = [ "amazon" ]
  most_recent = true 

  filter {
    name = "name"
    values = [ "amzn2-ami-hvm-*-x86_64-gp2" ]
  }
}