resource "aws_instance" "ec2" {
    instance_type = var.webserver_instance_type
    key_name = var.webserver_key_name
    vpc_security_group_ids = [var.webserver_vpc_security_group_ids]
    ami = var.webserver_ami
user_data = <<-EOF
              #!/bin/bash
              sudo apt install -y nginx
              systemctl start nginx
              echo "<h1>Hello from Terraform</h1>" > /var/www/html/index.html
              EOF
}