variable "name" {
  type = "string"
}

resource "aws_iam_user" "admin" {
  name = "${var.name}"
  path = "/"
}

resource "aws_iam_user_group_membership" "continuous" {
  user   = "${aws_iam_user.admin.name}"
  groups = ["admin"]
}

resource "aws_iam_access_key" "admin" {
  user = "${aws_iam_user.admin.name}"
}

output "access_key" {
  value = "${aws_iam_access_key.admin.id}"
}

output "secret_key" {
  value = "${aws_iam_access_key.admin.secret}"
}
