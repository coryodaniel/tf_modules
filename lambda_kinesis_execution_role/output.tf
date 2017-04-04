output "role_name" {
  value = "${aws_iam_role.instance.name}"
}

output "role_arn" {
  value = "${aws_iam_role.instance.arn}"
}
