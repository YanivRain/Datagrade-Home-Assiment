provider "aws" {
  region = "eu-central-1"
}

provider "random" {}

resource "random_password" "db_password" {
  length           = 16
  special          = true
  override_special = "_%@!"
}


resource "aws_db_instance" "postgres" {
  allocated_storage    = 10
  db_name              = "postgres"
  engine               = "postgres"
  engine_version       = "16.3"
  instance_class       = "db.t3.micro"
  username             = "foo"
  password             = random_password.db_password.result
  parameter_group_name = "default.postgres16"
  skip_final_snapshot  = true
  publicly_accessible  = true
  vpc_security_group_ids = [aws_security_group.db_access.id]
}

resource "aws_ssm_parameter" "db_username" {
  name  = "/db/username"
  type  = "SecureString"
  value = aws_db_instance.postgres.username
}

resource "aws_ssm_parameter" "db_password" {
  name  = "/db/password"
  type  = "SecureString"
  value = random_password.db_password.result
}

resource "aws_ssm_parameter" "db_endpoint" {
  name  = "/db/endpoint"
  type  = "String"
  value = aws_db_instance.postgres.endpoint
}

resource "aws_ssm_parameter" "db_port" {
  name  = "/db/port"
  type  = "String"
  value = aws_db_instance.postgres.port
}
