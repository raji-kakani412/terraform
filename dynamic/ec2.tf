resource "aws_security_group" "allow_ssh_terraform"{
  
  name = "allow_ssh_terraform"
  description = "Allowing port 22 for SSH access"
    
    # usually we allow everything in egress
  egress { #outgoing traffic and we dont need to authenticate
    from_port        = 0
    to_port          = 0
    protocol         = "-1" #-1 for everything
    cidr_blocks      = ["0.0.0.0/0"] #allow from everyone
    ipv6_cidr_blocks = ["::/0"]
  }

  dynamic "ingress"{ # incoming traffic
    for_each = var.ingress_rules
    content{
      from_port        = ingress.value["from_port"]
      to_port          = ingress.value["to_port"]
      protocol         = ingress.value["protocol"]
      cidr_blocks      = ingress.value["cidr_blocks"]
      ipv6_cidr_blocks = ["::/0"]
    }
  }

  tags = {
    Name = "allow_ssh"
  }
  
}

# security group resource can be placed below instance resource also . It first creates SG 

resource "aws_instance" "terraform" {

  ami = "ami-09c813fb71547fc4f"
  instance_type = "t3.micro"
  vpc_security_group_ids = [aws_security_group.allow_ssh_terraform.id]
  tags = {
    Name = "terraform"
  }

}
