output "vpc_id" {
  value = "${aws_vpc.suresh_vpc.id}"
}

output "nginx_security_group_id" {
  value = "${aws_security_group.nginx_sg.id}"
}

output "elb_security_group_id" {
  value = "${aws_security_group.elb_sg.id}"
}

output "nginx_subnet" {
  value = "${aws_subnet.nginx_subnet.id}"
}

output "rds_subnetA" {
  value = "${aws_subnet.postgres_subnet1.id}"
}

output "rds_subnetB" {
  value = "${aws_subnet.postgres_subnet2.id}"
}

output "nginx_interface" {
  value = "${aws_network_interface.nginx.id}"
}

