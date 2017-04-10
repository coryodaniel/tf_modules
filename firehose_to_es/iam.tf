resource "aws_iam_role" "instance" {
  name = "${var.firehose_name}"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "firehose.amazonaws.com"
      },
      "Action": "sts:AssumeRole",
      "Condition": {
        "StringEquals": {
          "sts:ExternalId": "${var.account_id}"
        }
      }
    }
  ]
}
EOF
}

// Ref: http://docs.aws.amazon.com/firehose/latest/dev/controlling-access.html#using-iam-es
resource "aws_iam_policy" "instance" {
  depends_on = ["aws_s3_bucket.instance", "aws_cloudwatch_log_stream.instance"]
  name        = "${var.firehose_name}"
  path        = "/"
  description = "ES Write permissions for firehose: ${var.firehose_name}"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "es:DescribeElasticsearchDomain",
        "es:DescribeElasticsearchDomains",
        "es:DescribeElasticsearchDomainConfig",
        "es:ESHttpPost",
        "es:ESHttpPut"
      ],
      "Resource": [
        "${aws_elasticsearch_domain.instance.arn}",
        "${aws_elasticsearch_domain.instance.arn}/*"
      ]
    },

    {
      "Effect": "Allow",
      "Action": [
        "es:ESHttpGet"
      ],
      "Resource": [
        "${aws_elasticsearch_domain.instance.arn}/_all/_settings",
        "${aws_elasticsearch_domain.instance.arn}/_cluster/stats",
        "${aws_elasticsearch_domain.instance.arn}/${var.es_index_name}*/_mapping/${var.es_type_name}",
        "${aws_elasticsearch_domain.instance.arn}/_nodes",
        "${aws_elasticsearch_domain.instance.arn}/_nodes/stats",
        "${aws_elasticsearch_domain.instance.arn}/_nodes/*/stats",
        "${aws_elasticsearch_domain.instance.arn}/_stats",
        "${aws_elasticsearch_domain.instance.arn}/${var.es_index_name}*/_stats"
      ]
    },
    {
      "Effect": "Allow",
      "Action": [
        "s3:AbortMultipartUpload",
        "s3:GetBucketLocation",
        "s3:GetObject",
        "s3:ListBucket",
        "s3:ListBucketMultipartUploads",
        "s3:PutObject"
      ],
      "Resource": [
        "${aws_s3_bucket.instance.arn}",
        "${aws_s3_bucket.instance.arn}/*"
      ]
    },
    {
      "Effect": "Allow",
      "Action": [
        "logs:PutLogEvents"
      ],
      "Resource": [
        "${aws_cloudwatch_log_stream.instance.arn}"
      ]
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "instance-attach" {
  depends_on = ["aws_iam_role.instance"]
  role       = "${aws_iam_role.instance.name}"
  policy_arn = "${aws_iam_policy.instance.arn}"
}
