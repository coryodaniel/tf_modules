output "firehose_arn" {
  value = "${aws_kinesis_firehose_delivery_stream.instance.arn}"
}

output "firehose_name" {
  value = "${aws_kinesis_firehose_delivery_stream.instance.name}"
}
