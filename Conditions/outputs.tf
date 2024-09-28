output "public_ip" {
    value = aws_instance.terraform.public_ip
    sensitive = false
    description = "public ip of the instance created"    
}