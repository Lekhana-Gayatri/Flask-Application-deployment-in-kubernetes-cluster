

resource "aws_instance" "webserver" {
  count=2
  ami=var.ami
  key_name = var.key
  security_groups = [aws_security_group.worker_sg.id]
}

resource "aws_instance" "db" {
  ami=var.ami
  key_name = var.key
  security_groups = [aws_security_group.db_sg.id]
}

resource "aws_instance" "master" {
  ami=var.ami
  key_name = var.key
  security_groups = [aws_security_group.master_sg.id]
}