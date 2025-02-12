variable "ingress_rules"{
    default= [
        {
            from_port=22
            to_port=22
            protocol="tcp"
            cidr_blocks = ["0.0.0.0/0"]
            description = "Openning port no 22"
        },
        {
            from_port=8080
            to_port=8080
            protocol="tcp"
            cidr_blocks = ["0.0.0.0/0"]
            description = "Openning port no 8080"
        },
                {
            from_port=80
            to_port=80
            protocol="tcp"
            cidr_blocks = ["0.0.0.0/0"]
            description = "Openning port no 80"
        }
    ]
}