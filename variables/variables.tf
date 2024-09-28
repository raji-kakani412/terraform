variable "ami_id"{
    type = string #type is optional
    default = "ami-09c813fb71547fc4f"
    description = "This is the ami id of devops-practice which is RHEL-9"
}

variable "instance_type"{
    type = string
    default = "t3.micro"
}

variable "tags"{
    default = {
        Name = "Backend"
        Project = "expense"
        Component = "backend"
        Environment = "Dev"
        Terraform = "true"
    }
}

variable "sg_name"{
    default = "allow_ssh_terraform"
}

variable "sg_description"{
    default = "Allowing port 22 for SSH access"
}

variable "from_port"{
    default = 22 #number
}

variable "to_port"{
    default = 22
}

variable "protocol"{
    default = "tcp"
}

variable "ingress_cidr_block"{
    type = list(string)
    default = ["0.0.0.0/0"]
}

# preference of variables
# 1.command line     use #terraform plan -var="<variable name>=value"
# 2.terraform.tfvars
# 3.environment variable  for this use export TF_VAR_<variable name>= value then use terraform plan. 
# To unset this ENVIRONMENT variable use unset TF_VAR_<variable name>
# 4.default
# 5.prompt if variable is not mentioned in any of the above
