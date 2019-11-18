data "template_file" "task_definition_json" {
  template = "${file("./task_definition.json")}"

  vars {
    container_name         = "${var.project_name}"
    docker_image           = "${aws_ecr_repository.ecr_repository.repository_url}:${var.docker_image}"
    project_name           = "${var.project_name}"
    environment            = "${terraform.workspace}"
    aws_region             = "${var.aws_region}"
  }
}

resource "aws_ecs_task_definition" "task_definition" {
  family                = "${terraform.workspace}-${var.project_name}"
  container_definitions = "${data.template_file.task_definition_json.rendered}"
}
