resource "aws_security_group" "web-node" {
  name = "web-node"
  description = "Web Security Group"
  ingress {
    from_port = 80
    to_port = 80
    protocol = "ssh"
   
  }
  ingress {
    from_port = 22
    to_port = 22
    protocol = "ssh"
   
  }    
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
   
  }
}
resource "aws_instance" "demo" {
  ami = lookup(var.AMI, var.REGION)
  instance_type = var.INSTANCE_TYPE
  key_name = var.KEY_NAME
  security_groups = ["${aws_security_group.web-node.name}"]
  tags = {
	Name = var.TAGS
  }
  count = var.COUNT
  allow {
    protocol = "ssh"
  }
}