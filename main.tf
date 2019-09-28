module "vpc" {
  source = "./vpc"
}

resource "aws_instance" "nginx" {
  ami           = "ami-add0abba" 
  instance_type = "t2.micro"
  user_data = "${file("nginx.sh")}"

  network_interface {
    network_interface_id = "${module.vpc.nginx_interface}"
    device_index         = 0
  }

  credit_specification {
    cpu_credits = "unlimited"
  }

  tags = {
    name        = "suresh-assignment"
    environment = "Democrance"
  }
}

resource "aws_elb" "suresh-elb" {
  name               = "suresh-assignment-elb"
  subnets            = ["${module.vpc.nginx_subnet}"]
  instances          = ["${aws_instance.nginx.id}"]
  security_groups    = ["${module.vpc.elb_security_group_id}"]

  listener {
    instance_port      = 80
    instance_protocol  = "http"
    lb_port            = 80
    lb_protocol        = "http"
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 5
    target              = "HTTP:80/index.nginx-debian.html"
    interval            = 15
  }

  tags = {
    name        = "suresh-assignment"
    environment = "Democrance"
  }
}

resource "aws_db_subnet_group" "dbgroup" {
  name       = "dbgroup"
  subnet_ids = ["${module.vpc.rds_subnetA}", "${module.vpc.rds_subnetB}"]
}

resource "aws_db_instance" "suresh-db" {
  allocated_storage    = 20
  storage_type         = "gp2"
  engine               = "postgres"
  engine_version       = "10.6"
  instance_class       = "db.t2.micro"
  name                 = "sureshdb"
  username             = "suresh"
  password             = "1qazXSW3edc"
  db_subnet_group_name = "${aws_db_subnet_group.dbgroup.name}"

  tags = {
    name        = "suresh-assignment"
    environment = "Democrance"
  }
}

output "elb_hostname" {
  value = "${aws_elb.suresh-elb.dns_name}"
}