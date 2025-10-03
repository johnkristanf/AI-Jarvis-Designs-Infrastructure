data "aws_ami" "ubuntu_latest" {
  most_recent = true
  owners      = ["099720109477"] # Canonical's AWS account ID

  # Use filters to match the latest Ubuntu Noble 24.04 LTS 64-bit Server HVM SSD AMI
  filter {
    name   = "name"
    # Replace noble-24.04 with the appropriate version if you need a different release
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
}


resource "aws_key_pair" "deployer" {
  key_name = var.key_pair_name
  public_key = file("~/.ssh/ai-jd-key-pair.pub")
}

resource "aws_instance" "web_server" {
  ami = data.aws_ami.ubuntu_latest.id
  instance_type = var.instance_type
  key_name = aws_key_pair.deployer.key_name
  subnet_id = var.public_subnet_id
  vpc_security_group_ids = [ var.web_server_sg_id ]

  root_block_device {
    volume_size           = 20
    volume_type           = "gp3"
    delete_on_termination = true
    encrypted             = true
    tags = {
      Name = "AI Jarvis Designs Root Volume"
    }
  }

  tags = {
    Name = "AI Jarvis Designs"
  }
}

# Elastic IP of the web server
resource "aws_eip" "web-server" {
  instance = aws_instance.web_server.id
  domain = "vpc"

  tags = {
    Name = "web-server-eip"
  }

  depends_on = [ var.internet_gateway ]
}