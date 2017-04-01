resource "aws_cloudwatch_log_group" "instance" {
  name = "${var.firehose_name}"
  tags {
    terraform = true
  }
}

resource "aws_cloudwatch_log_stream" "instance" {
  name           = "${var.firehose_name}"
  log_group_name = "${aws_cloudwatch_log_group.instance.name}"
}
