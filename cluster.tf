resource "aws_ecs_cluster" "cluster" {
  name = "${terraform.workspace}-${var.project_name}"
}
