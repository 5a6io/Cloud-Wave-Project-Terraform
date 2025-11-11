resource "aws_lb" "web_lb" {
    name = ""
    internal = false
    load_balancer_type = "application"
    subnets = [  
      
    ]
    security_groups = [

    ]
    ip_address_type = "ipv4"
    access_logs {
      enabled = false
      bucket = ""
      prefix = ""
    }
    idle_timeout = "60"
    enable_deletion_protection = "false"
    enable_http2 = "true"
    enable_cross_zone_load_balancing = "true"
}

resource "aws_lb_listener" "web_lb" {
    load_balancer_arn = "arn:aws:elasticloadbalancing:ap-northeast-1::loadbalancer/app/"
    port = 80
    protocol = "HTTP"

    default_action {
      fixed_response {
        content_type = "text/plain"
        status_code = "404"
      }
      type = "fixed-response"
    }
}

resource "aws_lb_target_group" "instance" {
    health_check {
      interval = 30
      path = "/"
      port = "traffic-port"
      protocol = "HTTP"
      timeout = 5
      unhealthy_threshold = 2
      healthy_threshold = 5
      matcher = "200"
    }
    port = 80
    protocol = "HTTP"
    target_type = "instance"
    vpc_id = "${aws_vpc.olivesafety-vpc-ap-01.id}"
    name = "DR"
}

resource "aws_lb_target_group" "web_lb_tg" {
    health_check {
      interval = 15
      path = "/"
      port = "traffic-port"
      protocol = "HTTP"
      timeout = 5
      unhealthy_threshold = 2
      healthy_threshold = 2
      matcher = "200"
    }
    port = 8080
    protocol = "HTTP"
    target_type = "ip"
    vpc_id = "${aws_vpc.olivesafety-vpc-ap-01.id}"
    name = "web_lb"
}