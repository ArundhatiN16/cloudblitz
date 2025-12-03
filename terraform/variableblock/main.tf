resource "aws_instance" "webserver" {
    instance_type = "t3.micro"
    ami = "ami-02b8269d5e85954ef"
    key_name = "8-08"
    vpc_security_group_ids = [ "sg-0c2bf931f8a6e8abb " ]
    disable_api_termination = false
    count = 2

}