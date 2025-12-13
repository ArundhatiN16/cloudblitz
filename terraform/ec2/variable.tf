variable "webserver_ami" {
    default = "ami-02b8269d5e85954ef"
}
variable "webserver_instance_type" {
    default = "t3.micro"  
}
variable "webserver_key_name" {
    default = "8-08"     
}
variable "webserver_vpc_security_group_ids" {
    default = [ "sg-0090938ab0d114e84" ]
}