output "instance_ip_addr" {
  value = aws_ecr_repository.aws-ecr.repository_url
}

output "nat_gateway_ip" {
  value = aws_eip.nat_gateway.public_ip
}

output "load_balancer_dns" {
  value = aws_alb.application_load_balancer.dns_name
}