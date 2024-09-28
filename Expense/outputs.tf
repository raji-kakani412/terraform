# for using output information we can use
# output.instances_info
# output.instances_info == aws_instance.expense

output "instances_info" {
  value       = aws_instance.expense
  description = "output of the aws instance created"
}