resource "aws_security_group" "External_ALB_SG" {
    name = "External ALB SG"
}

resource "aws_security_group" "WEB_SG" {
    name = "WEB_SG"
}

resource "aws_security_group" "INTERNAL_ALB_SG" {
    name = "INTERNAL ALB SG"
}

resource "aws_security_group" "WAS_SG" {
    name = "WAS SG"
}

resource "aws_security_group" "DB_SG" {
    name = "DB SG"
}

resource "aws_eks_cluster" "olivesafety_cluster" {
    name = "olivesafety"

    access_config {
      authentication_mode = "API"
    }

    role_arn = ""
    version = "1.31"

    vpc_config {
      subnet_ids = [ 
        aws_subnet.olivesafety-sub-pub-01.id,
        aws_subnet.olivesafety-sub-pub-02.id,
        aws_subnet.olivesafety-sub-pri-01.id,
        aws_subnet.olivesafety-sub-pri-02.id,
        aws_subnet.olivesafety-sub-pri-03.id,
        aws_subnet.olivesafety-sub-pri-04.id
       ]
    }
}

resource "aws_eks_node_group" "app" {
    cluster_name = aws_eks_cluster.olivesafety_cluster.name
    node_group_name = "app"
    instance_types = "m5.large"
    node_role_arn = ""

    subnet_ids = [ 
      aws_subnet.olivesafety-sub-pri-01.id,
      aws_subnet.olivesafety-sub-pri-02.id,
      aws_subnet.olivesafety-sub-pri-03.id,
      aws_subnet.olivesafety-sub-pri-04.id
     ]

     scaling_config {
       desired_size = 2
       min_size = 2
       max_size = 2
     }

     update_config {
       max_unavailable = 1
     }

     depends_on = [ 

      ]
}

resource "aws_eks_node_group" "web" {
    cluster_name = aws_eks_cluster.olivesafety_cluster.name
    node_group_name = "web"
    instance_types = "t3.medium"
    node_role_arn = ""

    scaling_config {
      desired_size = 2
      min_size = 2
      max_size = 2
    }

    subnet_ids = [
      aws_subnet.olivesafety-sub-pri-01.id,
      aws_subnet.olivesafety-sub-pri-02.id,
      aws_subnet.olivesafety-sub-pri-03.id,
      aws_subnet.olivesafety-sub-pri-04.id
    ]

    update_config {
       max_unavailable = 1
     }
    
}