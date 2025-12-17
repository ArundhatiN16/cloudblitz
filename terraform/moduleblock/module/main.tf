module "ec2" {
    source = "/mnt/c/Users/arund/Saved Games/Desktop/b61/terraform/moduleblock/main/ec2"
  webserver_ami = "ami-02b8269d5e85954ef"
  webserver_instance_type = "t3.micro"
  websever_key_name = "8-08"
  webserver_my_sg = module.vpc.webserver_sg_id
  webserver_subnetA = module.vpc.webserver_subnetA
}

module "vpc" {
  source = "/mnt/c/Users/arund/Saved Games/Desktop/b61/terraform/moduleblock/main/vpc"
  vpc_cidr = "10.0.0.0/16"
  vpc_subnetA = "10.0.1.0/24"
  public_ip = true
}