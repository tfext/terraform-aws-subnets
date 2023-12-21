output "subnet_ids" {
  value = aws_subnet.subnet.*.id
  description = "List of subnet ids"
}
