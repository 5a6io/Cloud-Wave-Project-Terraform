resource "aws_security_group" "db_sg" {
    name = "db sg"
    vpc_id = "${aws_vpc.olivesafety-vpc-ap-01.id}"
    ingress = {
        security_groups = []
        from_port = 3306
        protocol = "tcp"
        to_port = 3306
    }
}

resource "aws_rds_cluster" "primarydb" {
  database_name = "primary db"
  cluster_identifier = "olivesafety-aurora-mysql-secondary-cluster"
  db_cluster_parameter_group_name = "default.aurora-mysql8.0"
  db_subnet_group_name = ""
  engine = "aurora-mysql"
  port = 3306
  
}