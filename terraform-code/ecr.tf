resource "aws_ecr_repository" "ecr_repository" {
  name = "${terraform.workspace}-${var.project_name}"
}

resource "aws_ecr_repository_policy" "ecr_repository_policy" {
  repository = "${aws_ecr_repository.ecr_repository.name}"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "CodeBuildAccess",
      "Effect": "Allow",
      "Principal": {
        "Service": "codebuild.amazonaws.com"
      },
      "Action": [
        "ecr:GetDownloadUrlForLayer",
        "ecr:BatchGetImage",
        "ecr:BatchCheckLayerAvailability"
      ]
    }
  ]
}
EOF
}
