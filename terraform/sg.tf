
resource "aws_security_group" "db_sg" {
  name = "db_Sg"
}

resource "aws_security_group" "master_sg" {
  name        = "master-sg"
  description = "Security group for Kubernetes master node"
}
resource "aws_security_group" "worker_sg" {
  name        = "worker-sg"
  description = "Security group for Kubernetes worker nodes"
}

resource "aws_security_group_rule" "ssh_w" {
  security_group_id = aws_security_group.worker_sg.id
   type = "ingress"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["16.171.199.65"]  # Restrict to your IP address for SSH access
}

  
  resource "aws_security_group_rule" "http_w" {
  security_group_id = aws_security_group.worker_sg.id
  type = "ingress"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  
  }

  resource "aws_security_group_rule" "https_w" {
      security_group_id = aws_security_group.worker_sg.id
      type = "ingress"
      from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  
  }

resource "aws_security_group_rule" "kubelet_w" {
      security_group_id = aws_security_group.worker_sg.id
      type = "ingress"
    from_port   = 10250
    to_port     = 10250
    protocol    = "tcp"
    cidr_blocks = [ aws_instance.master.public_ip ]
  }
resource "aws_security_group_rule" "node_port_w" {
      security_group_id = aws_security_group.worker_sg.id
      type = "ingress"
    from_port   = 30000
    to_port     = 32767
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Restrict to specific IP ranges if needed for NodePort services
  }

resource "aws_security_group_rule" "runtime_w" {
      security_group_id = aws_security_group.worker_sg.id
      type = "ingress"
    from_port   = 2375
    to_port     = 2375
    protocol    = "tcp"
    cidr_blocks = [ aws_instance.master.public_ip ]
  }

resource "aws_security_group_rule" "egress_w" {
      security_group_id = aws_security_group.worker_sg.id
      type = "egress"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }


resource "aws_security_group_rule" "ssh_m" {
      security_group_id = aws_security_group.master_sg.id
      type = "ingress"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["16.171.199.65"]  # Restrict to your IP address for SSH access
  }

resource "aws_security_group_rule" "api_server_m" {
      security_group_id = aws_security_group.master_sg.id
      type = "ingress"
    from_port   = 6443
    to_port     = 6443
    protocol    = "tcp"
    cidr_blocks = [aws_instance.db.public_ip,aws_instance.webserver[0].public_ip,aws_instance.webserver[1].public_ip]  # Restrict to your IP address and worker nodes for API access
  }

resource "aws_security_group_rule" "etcd_m" {
      security_group_id = aws_security_group.master_sg.id
      type = "ingress"
    from_port   = 2379
    to_port     = 2380
    protocol    = "tcp"
    self        = true
  }

resource "aws_security_group_rule" "kubelet_m" {
      security_group_id = aws_security_group.master_sg.id
      type = "ingress"
    from_port   = 10250
    to_port     = 10250
    protocol    = "tcp"
    cidr_blocks = [ aws_instance.webserver[0].public_ip ,aws_instance.webserver[1].public_ip ,]
  }

resource "aws_security_group_rule" "scheduler_m" {
      security_group_id = aws_security_group.master_sg.id
      type = "ingress"
    from_port   = 10251
    to_port     = 10251
    protocol    = "tcp"
    self        = true
  }
resource "aws_security_group_rule" "controll_manager_m" {
      security_group_id = aws_security_group.master_sg.id
      type = "ingress"
    from_port   = 10252
    to_port     = 10252
    protocol    = "tcp"
    self        = true
  }

resource "aws_security_group_rule" "egress_m" {
      security_group_id = aws_security_group.master_sg.id
      type = "ingress"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

resource "aws_security_group_rule" "mysql_d" {
      security_group_id = aws_security_group.db_sg.id
      type = "ingress"
    from_port = 3306
    to_port = 3306
    protocol = "tcp"
    cidr_blocks = [ aws_instance.master.public_ip ]
  }

resource "aws_security_group_rule" "kubelet_d" {
      security_group_id = aws_security_group.db_sg.id
      type = "ingress"
    from_port   = 10250
    to_port     = 10250
    protocol    = "tcp"
    cidr_blocks = [ aws_instance.master.public_ip ]
  }

resource "aws_security_group_rule" "node_port_d" {
      security_group_id = aws_security_group.db_sg.id
      type = "ingress"
    from_port   = 30000
    to_port     = 32767
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Restrict to specific IP ranges if needed for NodePort services
  }

resource "aws_security_group_rule" "runtime_d" {
      security_group_id = aws_security_group.db_sg.id
      type = "ingress"
    from_port   = 2375
    to_port     = 2375
    protocol    = "tcp"
    cidr_blocks = [ aws_instance.master.public_ip ]
  }


resource "aws_security_group_rule" "egress_d" {
      security_group_id = aws_security_group.master_sg.id
      type = "egress"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  