provider "aws" {
  region = "eu-central-1"
}

provider "random" {}

resource "random_password" "db_password" {
  length           = 24
  override_special = "!#$&*()-=+[]{}<>:?"
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
  # vpc_security_group_ids = [aws_security_group.db_access.id]
}
