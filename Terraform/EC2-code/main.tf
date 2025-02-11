resource "aws_instance" "a" {
  ami = var.ami // ami id's are region specific so choose according to your region
  instance_type =  var.instance_type
  key_name = var.key_name
  vpc_security_group_ids = [aws_security_group.allow_tls.id] // all the security group ports will be selected with just adding this
  subnet_id = var.subnet_id
  associate_public_ip_address = var.public_ip
  iam_instance_profile = aws_iam_instance_profile.demo_role_profile.name
  tags = {
    Name = var.tags
    
  }
}

resource "aws_security_group" "allow_tls" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic and all outbound traffic"
  vpc_id      = var.vpc_id

  tags = {
    Name = "allow_tls"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_tls22" {
  security_group_id = aws_security_group.allow_tls.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}

resource "aws_vpc_security_group_ingress_rule" "allow_tls80" {
  security_group_id = aws_security_group.allow_tls.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.allow_tls.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}