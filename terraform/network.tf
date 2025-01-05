# resource "aws_security_group" "db_access" {
#   name        = "allow-db-access"
#   description = "Allow access to the RDS instance"
# }

# resource "aws_vpc_security_group_ingress_rule" "ingress" {
#   security_group_id = aws_security_group.db_access.id

#   cidr_ipv4   = "0.0.0.0/0"
#   from_port   = 5432
#   ip_protocol = "tcp"
#   to_port     = 5432
# }
