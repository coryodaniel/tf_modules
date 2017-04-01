resource "aws_iam_policy" "instance" {
  path        = "/"
  name_prefix = "firehose_writer_"
  description = "Firehose write permissions"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Action": [
        "firehose:DescribeDeliveryStream",
        "firehose:DeliveryStreamStatus",
        "firehose:PutRecordBatch",
        "firehose:PutRecord"
      ],
      "Resource": [
        "${var.firehose_arn}"
      ]
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "firehose_writer-attach" {
  depends_on = ["aws_iam_policy.instance"]
  role       = "${var.role_name}"
  policy_arn = "${aws_iam_policy.firehose_writer.arn}"
}
