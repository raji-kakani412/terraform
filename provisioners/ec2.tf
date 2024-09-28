resource "aws_security_group" "allow_ssh_terraform"{
  
  name = "allow_ssh_terraform"
  description = "Allowing port 22 for SSH access"
    
    
  egress { 
    from_port        = 0
    to_port          = 0
    protocol         = "-1" 
    cidr_blocks      = ["0.0.0.0/0"] 
    ipv6_cidr_blocks = ["::/0"]
  }

  ingress { 
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  ingress { # need this port 80 to open after installaing installation using the ip
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "allow_ssh"
  }
  
}


resource "aws_instance" "terraform" {

  ami = "ami-09c813fb71547fc4f"
  instance_type = "t3.micro"
  vpc_security_group_ids = [aws_security_group.allow_ssh_terraform.id]
  tags = {
    Name = "terraform"
  }
  # in this case laptop is my local
  provisioner "local-exec"{
      command = "echo ${self.public_ip} > public_ip.txt"
  }
  #for remote provisioner we need to establish connection
  connection{
    type ="ssh"
    user= "ec2-user"
    password = "DevOps321"
    host = self.public_ip
  }
  #provisioners will be executed at the time of creation only
  provisioner "remote-exec"{
    inline = [
      "sudo dnf install ansible -y",
      "sudo dnf install nginx -y ",
      "sudo systemctl start nginx"
    ]
  }
  provisioner "remote-exec"{
    when = destroy
    inline = [
      "sudo systemctl stop nginx "
    ]
  }

}
