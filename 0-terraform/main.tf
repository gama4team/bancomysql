locals {
  vpc_id = "vpc-0735473c0650139ff"
  subnet = "*private_wrmeplt*" ### Nesse campo precisaremos fazer um filtro das suas subnets, nesse casoo faremos de todas que contém priv no nome.
}

data "aws_subnet_ids" "main" {
  vpc_id = local.vpc_id
  filter {
    name   = "tag:Name"
    values = [local.subnet]
  }
}

data "http" "myip" {
  url = "http://ipv4.icanhazip.com"
}

provider "aws" {
  region = "sa-east-1"
}

resource "aws_instance" "bdec2" {
  ami                         = "ami-054a31f1b3bf90920"
  instance_type               = "t2.medium"
  subnet_id                   = tolist(data.aws_subnet_ids.main.ids)[0]
  associate_public_ip_address = true
  key_name                    = "key_wrmeplt_v2"
  root_block_device {
    encrypted = true
  }
  tags = {
    Name = "ec2-mysql"
  }
  vpc_security_group_ids = [aws_security_group.sec-mysql.id]
}

resource "aws_security_group" "sec-mysql" {
  name        = "acessos_ami"
  description = "acessos_ami inbound traffic"
  vpc_id      = data.aws_subnet_ids.main.id

  ingress = [
    {
      description      = "SSH from VPC"
      from_port        = 22
      to_port          = 22
      protocol         = "tcp"
      cidr_blocks      = ["10.0.1.0/24"]
      ipv6_cidr_blocks = ["::/0"]
      prefix_list_ids  = null,
      security_groups : null,
      self : null
    },
    {
      description      = "SSH from VPC"
      from_port        = 3306
      to_port          = 3306
      protocol         = "tcp"
      cidr_blocks      = ["10.0.1.0/24"]
      ipv6_cidr_blocks = ["::/0"]
      prefix_list_ids  = null,
      security_groups : null,
      self : null
    },
  ]

  egress = [
    {
      from_port        = 0
      to_port          = 0
      protocol         = "-1"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"],
      prefix_list_ids  = null,
      security_groups : null,
      self : null,
      description : "Libera dados da rede interna"
    }
  ]

}

# terraform refresh para mostrar o ssh
output "bdec2" {
  value = [
    "k8s_ami ",
    "id: ${aws_instance.bdec2.id} ",
    "private: ${aws_instance.bdec2.private_ip} ",
    "public: ${aws_instance.bdec2.public_ip} ",
    "public_dns: ${aws_instance.bdec2.public_dns} ",
    "ssh -i ~/.ssh/id_rsa ubuntu@${aws_instance.bdec2.public_dns} "
  ]
}
