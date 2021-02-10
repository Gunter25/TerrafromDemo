resource "aws_security_group" "allow_tls" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic"
  vpc_id      = aws_vpc.main.id

  ingress {
    description = "TLS from VPC"
    from_port   = 80
    to_port     = 80
    protocol    = "ssh"
    cidr_blocks = [aws_vpc.main.cidr_block]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
resource "aws_instance" "demo" {
  ami = lookup(var.AMI, var.REGION)
  instance_type = var.INSTANCE_TYPE
  key_name = var.KEY_NAME
  security_groups = ["${aws_security_group.allow_tls.name}"]
  tags = {
	Name = var.TAGS
	Name = "allow_tls"
  }
  count = var.COUNT
  allow {
    protocol = "ssh"
  }
}