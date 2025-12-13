data "aws_vpc" "my_vpc" {
    default = true
}

data "aws_subnets" "my_subnets" {
    filter {
      name = "vpc-id"
      values = [ data.aws_vpc.my_vpc.id ]
    }
}

resource "aws_security_group" "my_sg" {
  vpc_id = data.aws_vpc.my_vpc.id

  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = [ "0.0.0.0/0" ]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"] 
  }
}


resource "aws_lb" "my_lb" {
    name = "my-lb"
    subnets = data.aws_subnets.my_subnets.ids
    load_balancer_type = "application"
    security_groups = [ aws_security_group.my_sg.id ]
    internal = false

}

resource "aws_lb_target_group" "my_lb_tg" {
    name = "my-lb-tg"
    port = 80
    protocol = "HTTP"
    vpc_id = data.aws_vpc.my_vpc.id
}


resource "aws_lb_listener" "listener" {
    load_balancer_arn = aws_lb.my_lb.arn
    protocol = "HTTP"
    port = 80

    default_action {
      type = "forward"
      target_group_arn = aws_lb_target_group.my_lb_tg.arn
    }
  
}

resource "aws_launch_template" "my_tmp" {
    name_prefix = "my-tmp"
    image_id=  "ami-02b8269d5e85954ef"
    instance_type = "t3.micro"

    network_interfaces {
      associate_public_ip_address = true
      security_groups = [ aws_security_group.my_sg.id ]
    }

    user_data = base64encode(<<-EOF
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
        )
}

resource "aws_autoscaling_group" "my_asg" {
    desired_capacity = 2
    min_size = 1
    max_size = 3
    vpc_zone_identifier = data.aws_subnets.my_subnets.ids
    target_group_arns = [ aws_lb_target_group.my_lb_tg.arn ]
    health_check_grace_period = 120
    health_check_type = "ELB"
    launch_template {
      id = aws_launch_template.my_tmp.id
      version = "$Latest"
    }
  
}

output "alb_arn_name" {
  value = aws_lb.my_lb.dns_name
}