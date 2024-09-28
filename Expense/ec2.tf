resource "aws_security_group" "allow_ssh_terraform" {
  name        = var.sg_name
  description = var.sg_description

  # usually we allow everything in egress
  # this is called block-egress block
  egress { #outgoing traffic and we dont need to authenticate
    from_port        = 0
    to_port          = 0
    protocol         = "-1"          #-1 for everything
    cidr_blocks      = ["0.0.0.0/0"] #allow from everyone
    ipv6_cidr_blocks = ["::/0"]
  }

  ingress { # incoming traffic
    from_port        = var.from_port
    to_port          = var.to_port
    protocol         = var.protocol
    cidr_blocks      = var.ingress_cidr_block
    ipv6_cidr_blocks = ["::/0"]
  }
  tags = merge(
    var.common_tags,
    {
      Name = "allow_ssh"
    }
  )
}

# security group resource can be placed below instance resource also . It first creates SG 

resource "aws_instance" "expense" {
  count                  = length(var.instance_names)
  ami                    = data.aws_ami.ami_info.image_id
  instance_type          = var.instance_names[count.index] == "mysql" ? "t3.small" : "t3.micro"
  vpc_security_group_ids = [aws_security_group.allow_ssh_terraform.id]

  tags = merge(
    var.common_tags,
    {
      Name = var.instance_names[count.index]
    }
  )

}
