data "aws_vpc" "my_vpc" {
    default = true
}

data "aws_subnet" "my_subnets" {
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
    subnets = [ data.aws_subnet.my_subnets.id ]
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