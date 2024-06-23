
resource "aws_security_group" "worker_sg" {
  name        = "worker-sg"
  description = "Security group for Kubernetes worker nodes"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["16.171.199.65"]  # Restrict to your IP address for SSH access
  }

  
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  
  }

  ingress {
    from_port   = 10250
    to_port     = 10250
    protocol    = "tcp"
    security_groups = [aws_security_group.master_sg.id]
  }

  ingress {
    from_port   = 30000
    to_port     = 32767
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Restrict to specific IP ranges if needed for NodePort services
  }

  ingress {
    from_port   = 2375
    to_port     = 2376
    protocol    = "tcp"
    security_groups = [aws_security_group.master_sg.id]
  }

  ingress {
    from_port   = 8285
    to_port     = 8285
    protocol    = "udp"
    security_groups = [aws_security_group.worker_sg.id]
  }

  ingress {
    from_port   = 8472
    to_port     = 8472
    protocol    = "udp"
    security_groups = [aws_security_group.worker_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


resource "aws_security_group" "master_sg" {
  name        = "master-sg"
  description = "Security group for Kubernetes master node"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["16.171.199.65"]  # Restrict to your IP address for SSH access
  }

  ingress {
    from_port   = 6443
    to_port     = 6443
    protocol    = "tcp"
    cidr_blocks = [aws_instance.db.public_ip,aws_instance.webserver[0].public_ip,aws_instance.webserver[1].public_ip]  # Restrict to your IP address and worker nodes for API access
  }

  ingress {
    from_port   = 2379
    to_port     = 2380
    protocol    = "tcp"
    self        = true
  }

  ingress {
    from_port   = 10250
    to_port     = 10250
    protocol    = "tcp"
    security_groups = [aws_security_group.worker_sg.id]
  }

  ingress {
    from_port   = 10251
    to_port     = 10251
    protocol    = "tcp"
    self        = true
  }

  ingress {
    from_port   = 10252
    to_port     = 10252
    protocol    = "tcp"
    self        = true
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "db_sg" {
  name = "db_Sg"
  ingress {
    from_port = 3306
    to_port = 3306
    protocol = "tcp"
    security_groups = [ aws_security_group.master_sg.id ]
  }

  ingress {
    from_port   = 10250
    to_port     = 10250
    protocol    = "tcp"
    security_groups = [aws_security_group.master_sg.id]
  }

  ingress {
    from_port   = 30000
    to_port     = 32767
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Restrict to specific IP ranges if needed for NodePort services
  }

  ingress {
    from_port   = 2375
    to_port     = 2376
    protocol    = "tcp"
    security_groups = [aws_security_group.master_sg.id]
  }

  ingress {
    from_port   = 8285
    to_port     = 8285
    protocol    = "udp"
    security_groups = [aws_security_group.worker_sg.id]
  }

  ingress {
    from_port   = 8472
    to_port     = 8472
    protocol    = "udp"
    security_groups = [aws_security_group.worker_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


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