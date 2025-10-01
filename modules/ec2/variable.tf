variable "instance_type" {
  type = string
}

variable "public_subnet_id" {
  description = "Public subnet ID"
}

variable "web_server_sg_id" {
  description = "Web Server Security Group ID"
}


variable "internet_gateway" {
  description = "The main internet gateway"
}


variable "key_pair_name" {
  type = string
  description = "EC2 ssh key pair name"
}