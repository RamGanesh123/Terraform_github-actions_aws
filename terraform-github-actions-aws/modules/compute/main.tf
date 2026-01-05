data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }
}

resource "aws_security_group" "web" {
  vpc_id = var.vpc_id

  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [var.alb_sg_id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "web" {
  count                  = 2
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = var.instance_type
  subnet_id              = var.subnet_ids[count.index]
  vpc_security_group_ids = [aws_security_group.web.id]

  user_data = <<EOF
#!/bin/bash
apt update -y
apt install -y apache2
systemctl start apache2
systemctl enable apache2

echo "<h1>Web Page ${count.index + 1}</h1>" > /var/www/html/index.html
echo "<h2>Served by Instance ${count.index + 1}</h2>" >> /var/www/html/index.html
EOF

  tags = {
    Name = "${var.env}-web-${count.index + 1}"
  }
}

resource "aws_lb_target_group_attachment" "attach" {
  count            = 2
  target_group_arn = var.target_group_arn
  target_id        = aws_instance.web[count.index].id
  port             = 80
}
