resource "aws_vpc" "suresh_vpc" {
  cidr_block = "172.16.0.0/16"

  tags = {
    Name = "suresh-assignment"
    environment = "Democrance"
  }
}

resource "aws_internet_gateway" "democ_gw" {
  vpc_id = "${aws_vpc.suresh_vpc.id}"

  tags = {
    Name = "suresh-assignment"
    environment = "Democrance"
  }
}

resource "aws_route_table" "democ_rt" {
  vpc_id = "${aws_vpc.suresh_vpc.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.democ_gw.id}"
  }

  tags = {
    Name = "suresh-assignment"
    environment = "Democrance"
  }
}

resource "aws_main_route_table_association" "rt_association" {
  vpc_id         = "${aws_vpc.suresh_vpc.id}"
  route_table_id = "${aws_route_table.democ_rt.id}"
}

resource "aws_network_acl" "DemocACL" {
  vpc_id = "${aws_vpc.suresh_vpc.id}"

  egress {
    protocol   = "tcp"
    rule_no    = 300
    action     = "allow"
    cidr_block = "172.16.0.0/16"
    from_port  = 443
    to_port    = 443
  }

  ingress {
    protocol   = "tcp"
    rule_no    = 200
    action     = "allow"
    cidr_block = "172.16.0.0/16"
    from_port  = 80
    to_port    = 80
  }

  ingress {
    protocol   = "tcp"
    rule_no    = 100
    action     = "allow"
    cidr_block = "172.16.0.0/16"
    from_port  = 22
    to_port    = 22
  }

  tags = {
    name        = "suresh"
    environment = "Democrance"
  }
}

resource "aws_security_group" "elb_sg" {
  name        = "elb_sg"
  description = "Allow inbound traffic for nginx"
  vpc_id      = "${aws_vpc.suresh_vpc.id}"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks     = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks     = ["0.0.0.0/0"]
  }  

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }

  tags = {
    name        = "suresh-assignment"
    environment = "Democrance"
  }
}

resource "aws_security_group" "nginx_sg" {
  name        = "nginx_sg"
  description = "Allow inbound traffic for nginx"
  vpc_id      = "${aws_vpc.suresh_vpc.id}"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks     = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks     = ["0.0.0.0/0"]
  }  

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }

  tags = {
    name        = "suresh-assignment"
    environment = "Democrance"
  }
}

resource "aws_subnet" "nginx_subnet" {
  vpc_id            = "${aws_vpc.suresh_vpc.id}"
  cidr_block        = "172.16.10.0/24"
  availability_zone = "us-east-1a"
  map_public_ip_on_launch = "true"

  tags = {
    Name = "suresh-assignment"
    environment = "Democrance"
  }
}

resource "aws_subnet" "postgres_subnet1" {
  vpc_id            = "${aws_vpc.suresh_vpc.id}"
  cidr_block        = "172.16.20.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "suresh-assignment"
    environment = "Democrance"
  }
}

resource "aws_subnet" "postgres_subnet2" {
  vpc_id            = "${aws_vpc.suresh_vpc.id}"
  cidr_block        = "172.16.30.0/24"
  availability_zone = "us-east-1b"

  tags = {
    Name = "suresh-assignment"
    environment = "Democrance"
  }
}

resource "aws_network_interface" "nginx" {
  subnet_id   = "${aws_subnet.nginx_subnet.id}"
  security_groups = ["${aws_security_group.nginx_sg.id}"]

  tags = {
    Name = "primary_network_interface"
  }
}
