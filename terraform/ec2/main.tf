resource "aws_instance" "ec2" {
    instance_type = var.webserver_instance_type
    key_name = var.webserver_key_name
    vpc_security_group_ids = [var.webserver_vpc_security_group_ids]
    ami = var.webserver_ami

user_data = <<-EOF
    #!/bin/bash
    sudo apt update -y
    sudo apt install nginx -y
    sudo systemctl enable nginx
    sudo systemctl start nginx
    echo "Nginx Page" > /var/www/html/index.html
  EOF
}