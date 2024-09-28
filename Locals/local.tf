locals {
    domain_name = "devops-aws.tech"
    zone_id = "Z0524637U008EQP6TTGD"
    # count.index will not work with locals so we cannot use when looping is needed
    # instance_type = var.environment == "prod"? "t3.medium": "t3.micro'"
    # we use this to store expressions also
}
