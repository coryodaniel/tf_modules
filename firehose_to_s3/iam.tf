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

resource "aws_iam_policy" "instance" {
  depends_on = ["aws_s3_bucket.instance", "aws_cloudwatch_log_stream.instance"]
  name        = "${var.firehose_name}"
  path        = "/"
  description = "S3 Write permissions for firehose: ${var.firehose_name}"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
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

resource "aws_iam_role_policy_attachment" "s3_writer-attach" {
  depends_on = ["aws_iam_role.instance"]
  role       = "${aws_iam_role.instance.name}"
  policy_arn = "${aws_iam_policy.instance.arn}"
}
