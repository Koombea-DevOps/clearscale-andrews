resource "aws_lb_target_group" "target_group" {
  name     = "${terraform.workspace}-${var.project_name}"
  port     = 80
  protocol = "HTTP"
  vpc_id   = "${aws_vpc.main.id}"

  health_check {
    path                = "/"
    matcher             = 200
    timeout             = 3
    interval            = 5
    healthy_threshold   = 5
    unhealthy_threshold = 5
  }
}
