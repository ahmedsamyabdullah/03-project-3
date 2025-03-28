output "main_vm_ip" {
  description = "IP add of main_vm ec2 instance"
  value = aws_instance.main_vm.public_ip
}