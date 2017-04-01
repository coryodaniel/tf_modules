resource "aws_s3_bucket" "instance" {
  bucket = "${var.bucket_name}"
  acl    = "private"
  tags {
    terraform = true
  }
}
