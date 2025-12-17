resource "aws_vpc" "my_vpc" {
    cidr_block = var.vpc_cidr
}
resource "aws_subnet" "my_subnet" {
    vpc_id = aws_vpc.my_vpc.id
    cidr_block = var.vpc_subnetA
    map_public_ip_on_launch = var.public_ip
    tags = {
      Name = "subnet-A"
    }
}

resource "aws_internet_gateway" "my_igw" {
    vpc_id = aws_vpc.my_vpc.id
  
}

resource "aws_route_table" "my_rt" {
    vpc_id = aws_vpc.my_vpc.id

    route {
        cidr_block = "10.0.1.0/24"
        gateway_id = aws_internet_gateway.my_igw.id
    }
  
}

resource "aws_route_table_association" "my_rta" {
  subnet_id      = aws_subnet.my_subnet.id
  route_table_id = aws_route_table.my_rt.id
}

resource "aws_security_group" "my_sg" {
    vpc_id = aws_vpc.my_vpc
ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
}
ingress  {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
}
ingress  {
    from_port = 8080
    to_port = 8080
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0./0"]
}
egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
}
}