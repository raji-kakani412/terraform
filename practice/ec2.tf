resource aws_security_group "allow_ssh"{
    name = "allow_ssh_terraform"
    description = "allowing port 22 for ssh"

    egress{
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
        ipv6_cidr_blocks = ["::/0"]
    }
    ingress{
        from_port = var.from_port
        to_port = var.to_port
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        ipv6_cidr_blocks = ["::/0"]
    }

    tags ={
        name= "allow_ssh"
    }

}

resource aws_instance "terraform"{
    ami id = var.ami_id
    instance_type = var.instance_type
    vpc_security_group_ids = [aws_security_group.allow_ssh]
    allow_overwrite = true

    tags = {
        name = "Terraform"
    }

}

