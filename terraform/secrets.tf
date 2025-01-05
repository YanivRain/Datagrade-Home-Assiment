provider "kubernetes" {
  config_path = "~/.kube/config"
}

resource "kubernetes_secret" "db_secrets" {
  metadata {
    name      = "db-credentials"
    namespace = "default"
  }

  data = {
    username = aws_db_instance.postgres.username
    password = random_password.db_password.result
    endpoint = aws_db_instance.postgres.address
  }

  type = "Opaque"
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
  value = aws_db_instance.postgres.address
}

resource "aws_ssm_parameter" "db_port" {
  name  = "/db/port"
  type  = "String"
  value = aws_db_instance.postgres.port
}
