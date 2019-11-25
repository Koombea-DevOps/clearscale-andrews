resource "aws_cloudwatch_log_group" "logs" {
  name = "${terraform.workspace}-${var.project_name}"

  retention_in_days = 30
}
