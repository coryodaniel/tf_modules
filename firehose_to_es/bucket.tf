resource "aws_s3_bucket" "instance" {
  bucket = "${var.bucket_name}"
  acl    = "private"
  force_destroy = "${var.force_destroy_bucket}"
  tags {
    terraform = true
  }
}
