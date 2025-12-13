resource "aws_instance" "ec2" {
    instance_type = var.webserver_instance_type
    key_name = var.webserver_key_name
    vpc_security_group_ids = [var.webserver_vpc_security_group_id]
    ami = var.webserver_ami
}