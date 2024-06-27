

resource "aws_instance" "webserver" {
  count=2
  ami=var.ami
  instance_type = "t3.micro"
  key_name = var.key
  security_groups = [aws_security_group.worker_sg.name]
  tags = {
  name="slaves"
  }
}

resource "aws_instance" "db" {
  ami=var.ami
  instance_type="t3.micro"
  key_name = var.key
  security_groups = [aws_security_group.db_sg.name]
  tags = {
  name="slave3"
  }
}

resource "aws_instance" "master" {
  ami=var.ami
  key_name = var.key
  security_groups = [aws_security_group.master_sg.name]
  instance_type= "t3.micro"
  tags = {
  name="master"
  }
}

resource "aws_instance" "jenkins-sonar" {
  ami=var.ami
  key_name = var.key
  security_groups = [aws_security_group.js.name]
  instance_type= "t3.micro"
  tags = {
  name="jenkins-sonar"
  }
}
resource "aws_instance" "monitor" {
  ami=var.ami
  key_name = var.key
  security_groups = [aws_security_group.monitor.name]
  instance_type= "t3.micro"
  tags = {
  name="monitor"
  }
}