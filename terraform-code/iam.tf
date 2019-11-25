resource "aws_iam_instance_profile" "ec2_instance_profile" {
  name = "${terraform.workspace}-${var.project_name}-instance-profile"
  role = "${aws_iam_role.ec2_instance_role.name}"
}

resource "aws_iam_role" "ec2_instance_role" {
  name = "${terraform.workspace}-${var.project_name}-instance-role"

  assume_role_policy = <<EOF
{
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Sid": ""
    }
  ],
  "Version": "2012-10-17"
}
EOF

  tags = {
    Name = "${terraform.workspace}-${var.project_name}-ec2-instance-role"
  }
}

resource "aws_iam_policy_attachment" "ecs_instance_policy_attachment" {
  name       = "${terraform.workspace}-${var.project_name}-instance-policy-attachment"
  roles      = ["${aws_iam_role.ec2_instance_role.name}"]
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role"
}

resource "aws_iam_policy_attachment" "ssm_instance_policy_attachment" {
  name       = "${terraform.workspace}-${var.project_name}-instance-policy-attachment"
  roles      = ["${aws_iam_role.ec2_instance_role.name}"]
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMReadOnlyAccess"
}

resource "aws_iam_policy_attachment" "sns_instance_policy_attachment" {
  name       = "${terraform.workspace}-${var.project_name}-instance-policy-attachment"
  roles      = ["${aws_iam_role.ec2_instance_role.name}"]
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSIoTDeviceDefenderPublishFindingsToSNSMitigationAction"
}

resource "aws_iam_role" "ecs_service_role" {
  name = "${terraform.workspace}-${var.project_name}-ecs-service-role"

  assume_role_policy = <<EOF
{
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Effect": "Allow",
      "Principal": {
        "Service": "ecs.amazonaws.com"
      },
      "Sid": ""
    }
  ],
  "Version": "2012-10-17"
}
EOF

  tags = {
    Name = "${terraform.workspace}-${var.project_name}-ecs-service-role"
  }
}

resource "aws_iam_policy_attachment" "ecs_service_policy_attachment" {
  name       = "${terraform.workspace}-${var.project_name}-instance-policy-attachment"
  roles      = ["${aws_iam_role.ecs_service_role.name}"]
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceRole"
}
