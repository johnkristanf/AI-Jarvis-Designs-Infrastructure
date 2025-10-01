terraform {
  required_providers {
    aws = {
        source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

provider "aws" {
  region  = var.aws_region
  profile = var.aws_profile
}
 

module "vpc" {
  source = "./modules/vpc"
  main_vpc_cidr_block = var.main_vpc_cidr_block
  public_subnet_cidr = var.public_subnet_cidr
}

module "security_groups" {
  source = "./modules/security_groups"
  main_vpc_id = module.vpc.main_vpc_id
}


module "ec2" {
  source = "./modules/ec2" 
  instance_type = var.instance_type
  public_subnet_id = module.vpc.public_subnet_id
  internet_gateway = module.vpc.internet_gateway
  web_server_sg_id = module.security_groups.web_server_sg_id
  key_pair_name = var.key_pair_name
}