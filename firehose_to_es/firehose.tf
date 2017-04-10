resource "aws_kinesis_firehose_delivery_stream" "instance" {
  depends_on = ["aws_elasticsearch_domain.instance",
                "aws_iam_role.instance",
                "aws_s3_bucket.instance",
                "aws_cloudwatch_log_group.instance",
                "aws_cloudwatch_log_stream.instance"]

  name        = "${var.firehose_name}"
  destination = "elasticsearch"

  elasticsearch_configuration {
    domain_arn = "${aws_elasticsearch_domain.instance.arn}"
    role_arn   = "${aws_iam_role.instance.arn}"
    s3_backup_mode = "${var.backup_all ? "AllDocuments": "FailedDocumentsOnly"}"
    index_rotation_period = "${var.rotation_period}"
    index_name = "${var.es_index_name}"
    type_name  = "${var.es_type_name}"

    buffer_size     = "${var.es_buffer_size}"
    buffer_interval = "${var.es_buffer_interval}"

    cloudwatch_logging_options {
      enabled = true
      log_group_name  = "${aws_cloudwatch_log_group.instance.name}"
      log_stream_name = "${aws_cloudwatch_log_stream.instance.name}"
    }
  }

  s3_configuration {
    role_arn        = "${aws_iam_role.instance.arn}"
    bucket_arn      = "${aws_s3_bucket.instance.arn}"
    buffer_size     = "${var.s3_buffer_size}"
    buffer_interval = "${var.s3_buffer_interval}"
    compression_format = "GZIP"
  }
}
