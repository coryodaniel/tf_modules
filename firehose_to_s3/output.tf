output "firehose_arn" {
  value = "${aws_kinesis_firehose_delivery_stream.instance.arn}"
}

output "firehose_name" {
  value = "${aws_kinesis_firehose_delivery_stream.instance.name}"
}

output "bucket_arn" {
  value = "${aws_s3_bucket.instance.arn}"
}

output "bucket_id" {
  value = "${aws_s3_bucket.instance.id}"
}
