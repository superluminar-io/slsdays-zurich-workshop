provider "aws" {
  alias   = "tf-stage-mgmt"
  region  = "eu-central-1"
  version = "~> 1.40"

  assume_role {
    role_arn     = "arn:aws:iam::823945482635:role/OrganizationAccountAccessRole"
    session_name = "sls-days-zurich"
  }
}

resource "aws_iam_group" "admin" {
  name = "admin"
}

resource "aws_iam_group_policy" "admin" {
  name  = "admin"
  group = "${aws_iam_group.admin.id}"

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": "*",
            "Resource": "*"
        }
    ]
}
EOF
}

module "user-01" {
  source = "user"
  name   = "user-01"
}
