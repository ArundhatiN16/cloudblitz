resource "aws_instance" "ec2" {
    instance_type = var.webserver_instance_type
    key_name = var.webserver_key_name
    vpc_security_group_ids = [var.webserver_vpc_security_group_ids]
    ami = var.webserver_ami
user_data = <<-EOF
              #!/bin/bash
              sudo apt update -y
              sudo apt install -y apache2
              systemctl start apache2
              cat <<HTML > /var/www/html/index.html
              <!DOCTYPE html>
              <html>
              <head>
                  <title>Terraform EC2 Web Server</title>
              </head>
              <body style="background-color: #f4f4f4; text-align: center;">
                  <h1>🚀 Hello from Terraform User Data</h1>
                  <p>EC2 instance successfully launched using Terraform</p>
                  <p><strong>Environment:</strong> Dev</p>
              </body>
              </html>
              HTML
              EOF
}