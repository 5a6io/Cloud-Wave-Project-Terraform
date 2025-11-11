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