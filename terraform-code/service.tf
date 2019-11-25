resource "aws_ecs_service" "ecs_service" {
  name                               = "${terraform.workspace}-${var.project_name}"
  cluster                            = "${aws_ecs_cluster.cluster.id}"
  task_definition                    = "${aws_ecs_task_definition.task_definition.arn}"
  desired_count                      = 1
  iam_role                           = "${aws_iam_role.ecs_service_role.name}"
  health_check_grace_period_seconds  = 50
  deployment_minimum_healthy_percent = 50
  depends_on                         = ["aws_lb_listener.http"]

  ordered_placement_strategy {
    type  = "spread"
    field = "instanceId"
  }

  ordered_placement_strategy {
    type  = "spread"
    field = "attribute:ecs.availability-zone"
  }

  load_balancer {
    target_group_arn = "${aws_lb_target_group.target_group.arn}"
    container_name   = "${var.project_name}"
    container_port   = 80
  }

  lifecycle {
    create_before_destroy = true
  }
}
