resource "aws_instance" "demo_tf" {
  instance_type          = "t3.micro"
  ami                    = "ami-0d176f79571d18a8f"
  key_name               = "8-08"
  vpc_security_group_ids = ["sg-0c2bf931f8a6e8abb"]
}