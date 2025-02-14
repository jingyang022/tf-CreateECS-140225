resource "aws_security_group" "ecs-sg" {
    name_prefix = "yap-ecs-sg" #Security group name, e.g. jazeel-terraform-security-group
    description = "Security group for ECS containers"
    vpc_id = data.aws_vpc.default.id #VPC ID (Same VPC as your EC2 subnet above), E.g. vpc-xxxxxxx
    
    lifecycle {
      create_before_destroy = true
    }
}

resource "aws_vpc_security_group_ingress_rule" "allow_tls_ipv4" {
    security_group_id = aws_security_group.ecs-sg.id
    cidr_ipv4 = "0.0.0.0/0"
    from_port = 8080
    ip_protocol = "tcp"
    to_port = 8080
}