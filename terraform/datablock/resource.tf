resource "aws_instance" "webserver" {
    instance_type = var.webserver_instance_type
    ami = var.webserver_ami
    key_name = var.webserver_key_name
    vpc_security_group_ids = [var.webserver_vpc_security_group_ids , aws_security_group.webserver.id , data.aws_security_group.aws_sg.id ] 
    disable_api_termination = var.webserver_disable_api_termination
}
resource "aws_security_group" "webserver" {
    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = [ "0.0.0.0/0" ]
  }
}