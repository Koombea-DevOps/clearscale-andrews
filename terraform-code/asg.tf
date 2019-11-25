data "template_file" "user_data" {
  template = "${file("./user-data.sh")}"

  vars {
    ecs_cluster_name = "${terraform.workspace}-${var.project_name}"
  }
}

resource "aws_launch_configuration" "launch_configuration" {
  name                 = "${terraform.workspace}-${var.project_name}"
  image_id             = "${data.aws_ami.ecs_ami.id}"
  instance_type        = "t2.micro"
  user_data            = "${data.template_file.user_data.rendered}"
  key_name             = "andrews.herrera"
  iam_instance_profile = "${aws_iam_instance_profile.ec2_instance_profile.name}"
  enable_monitoring    = "true"
  security_groups      = ["${aws_security_group.ssh.id}", "${aws_security_group.http.id}"]

  root_block_device {
    volume_type = "gp2"
    volume_size = 8
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "autoscaling_group" {
  name                      = "${terraform.workspace}-${var.project_name}"
  launch_configuration      = "${aws_launch_configuration.launch_configuration.id}"
  vpc_zone_identifier       = ["${aws_subnet.public.*.id}"]
  min_size                  = 1
  max_size                  = 2
  desired_capacity          = 1
  health_check_grace_period = 10

  tag {
    key                 = "Name"
    value               = "${terraform.workspace}-${var.project_name}"
    propagate_at_launch = true
  }

  lifecycle {
    create_before_destroy = true
  }
}
