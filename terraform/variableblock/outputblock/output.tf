output "webserver_ip" {
    value = aws_instance.webserver.public_ip
}
output "webserver_public_dns" {
    value = aws_instance.webserver_public_dns
}
output "webserver_sg_id"{
    value = aws_security_group.webserver_sg_id
}
output "webserver_sg_arn" {
  value = aws_security_group.webserver_sg_arn
}


  
