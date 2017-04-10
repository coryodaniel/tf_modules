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

output "elasticsearch_arn" {
  value = "${aws_elasticsearch_domain.instance.arn}"
}

output "elasticsearch_domain_id" {
  value = "${aws_elasticsearch_domain.instance.domain_id}"
}

output "elasticsearch_endpoint" {
  value = "${aws_elasticsearch_domain.instance.endpoint}"
}
