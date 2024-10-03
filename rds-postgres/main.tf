resource "aws_secretsmanager_secret" "db_password" {
  name = "db_password"
}

resource "aws_rds_cluster" "default" {
  cluster_identifier      = "aurora-cluster"
  engine                 = "aurora-postgresql"
  master_username         = "masteruser"
  master_password         = aws_secretsmanager_secret.db_password.secret_string
  database_name           = "mydb"
  skip_final_snapshot     = true

  vpc_security_group_ids = [aws_security_group.rds_sg.id]

  depends_on = [aws_secretsmanager_secret_version.db_password_version]
}

resource "aws_security_group" "rds_sg" {
  vpc_id = var.vpc_id

  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]  # Permitir acesso das EC2
  }
}

resource "aws_rds_cluster_instance" "default" {
  count               = 2
  cluster_identifier  = aws_rds_cluster.default.id
  instance_class      = "db.t3.medium"
}

output "endpoint" {
  value = aws_rds_cluster.default.endpoint
}
