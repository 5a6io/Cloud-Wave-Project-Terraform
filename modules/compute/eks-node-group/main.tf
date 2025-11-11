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