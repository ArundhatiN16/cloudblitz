variable "webserver_instance_type" {
    default = t3.small
}
variable "webserver_ami" {
    default = "ami-02b8269d5e85954ef"
}
variable "webserver_key_name" {
    default = "8-08"
}
variable "webserver_vpc_security_group_ids" {
    default = ["sg-0c2bf931f8a6e8abb"]
}
variable "webserver_disable_api_termination" {
    default = false
}
variable "webserver_count" {
    default = 2
}  
