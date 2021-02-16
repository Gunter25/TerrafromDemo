resource "aws_instance" "demo" {
  ami = lookup(var.AMI, var.REGION)
  instance_type = var.INSTANCE_TYPE
  key_name = var.KEY_NAME
  vpc_security_group_ids = [aws_security_group.demo.id]

  count = var.COUNT
}

resource "aws_security_group" "demo" {
  name = "demo"
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "ssh"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_eip" "ip-test-env" {
 
  vpc      = true
}
