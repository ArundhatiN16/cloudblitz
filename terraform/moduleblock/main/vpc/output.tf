output "subnet_id" {
    value = aws_subnet.my_subnet.id
  
}

output "vpc_id" {
    value = aws_vpc.my_vpc.id
  
}

output "webserver_sg_id" {
    value = aws_security_group.my_sg.id
  
}