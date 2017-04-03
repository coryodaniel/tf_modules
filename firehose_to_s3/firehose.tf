resource "aws_kinesis_firehose_delivery_stream" "instance" {
  depends_on = ["aws_iam_role.instance",
                "aws_s3_bucket.instance",
                "aws_cloudwatch_log_group.instance",
                "aws_cloudwatch_log_stream.instance"]

  name        = "${var.firehose_name}"
  destination = "s3"

  s3_configuration {
    role_arn        = "${aws_iam_role.instance.arn}"
    bucket_arn      = "${aws_s3_bucket.instance.arn}"
    buffer_size     = "${var.buffer_size}"
    buffer_interval = "${var.buffer_interval}"

    cloudwatch_logging_options {
      enabled = true
      log_group_name  = "${aws_cloudwatch_log_group.instance.name}"
      log_stream_name = "${aws_cloudwatch_log_stream.instance.name}"
    }
  }
}
