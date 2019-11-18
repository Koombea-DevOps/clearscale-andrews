resource "aws_lb" "public_lb" {
  name               = "${terraform.workspace}-${var.project_name}"
  load_balancer_type = "application"
  security_groups    = ["${aws_security_group.http.id}"]
  subnets            = ["${aws_subnet.public.*.id}"]

  tags {
    Name = "${terraform.workspace}-${var.project_name}"
  }
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = "${aws_lb.public_lb.arn}"
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = "${aws_lb_target_group.target_group.arn}"
  }
}
