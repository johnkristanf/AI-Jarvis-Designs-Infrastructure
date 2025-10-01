variable "aws_region" {
  type    = string
  default = "ap-southeast-1"
}

variable "aws_profile" {
  type    = string
  default = "johnkristan.torremocha01"
}


# NETWORK ENVIRONMENTS
variable "main_vpc_cidr_block" {
  type    = string
  default = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
  description = "CIDR block for public subnet"
  default     = "10.0.1.0/24"
}


# EC2 RELATED ENVIRONMENTS
variable "instance_type" {
  description = "EC2 instance type"
  default     = "t2.micro"
}

variable "key_pair_name" {
  default = "ai-jd-key-pair"
  type = string
}