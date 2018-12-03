resource "aws_lb" "my-website" {
  name               = "${element(split(".", var.zone_name ),0)}-www"
  load_balancer_type = "application"
  internal           = false
  idle_timeout       = 400
  subnets            = "${var.subnets}"
  security_groups    = "${var.securitygroups}"
  enable_http2       = true
}

resource "aws_lb_listener" "my_website_https" {
  load_balancer_arn = "${aws_lb.my-website.arn}"
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2015-05"
  certificate_arn   = "${var.cert_arn}"

  default_action {
    type = "redirect"

    redirect {
      protocol    = "HTTPS"
      status_code = "HTTP_301"
      host        = "www.#{host}"
      path        = "/#{path}"
      query       = "#{query}"
    }

    # target_group_arn = "${aws_lb_target_group.my_website_http.arn}"
  }
}

resource "aws_lb_listener" "my_website_http" {
  load_balancer_arn = "${aws_lb.my-website.arn}"

  port     = "80"
  protocol = "HTTP"

  default_action {
    type = "redirect"

    #  target_group_arn = "${aws_lb_target_group.my_website_http.arn}"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
      host        = "#{host}"
      path        = "/#{path}"
      query       = "#{query}"
    }
  }
}
