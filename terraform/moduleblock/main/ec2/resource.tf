resource "aws_instance" "webserver" {
    instance_type = var.webserver_instance_type
    ami = var.webserver_ami
    key_name = var.websever_key_name
    vpc_security_group_ids = var.my_sg
    subnet_id = [var.webserver_subnetA]
}