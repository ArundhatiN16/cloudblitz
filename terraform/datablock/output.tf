output "webserver_pub_ip" {
    value = aws_instance.webserver.public_ip
  }
output "webserver_private_ip" {
    value = aws_instance.webserver.private_ip
  }
output "aws_asg" {
    value = data.aws_security_group.aws_sg.id
}