

resource "aws_instance" "slaves" {
  count=2
  ami=var.ami
  instance_type = "t3.large"
  key_name = var.key
  security_groups = [aws_security_group.book_store_sg.name]
  tags = {
  name="slaves"
  }
}


resource "aws_instance" "master" {
  ami=var.ami
  key_name = var.key
  security_groups = [aws_security_group.book_store_sg.name]
  instance_type= "t3.large"
  tags = {
  name="master"
  }
}

resource "aws_instance" "jenkins-sonar" {
  ami=var.ami
  key_name = var.key
  security_groups = [aws_security_group.book_store_sg.name]
  instance_type= "t3.large"
  tags = {
  name="jenkins-sonar"
  }
}
resource "aws_instance" "monitor" {
  ami=var.ami
  key_name = var.key
  security_groups = [aws_security_group.book_store_sg.name]
  instance_type= "t3.large"
  tags = {
  name="monitor"
  }
}
