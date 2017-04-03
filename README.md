# Terraform modules


## Firehose to S3

[firehose_to_s3](./firehose_to_s3/) is a module that creates a Kinesis Firehose with an S3 destination.

This module will create:
* Kinesis Firehose
* Private S3 Bucket, logging enabled
* IAM roles and policies for writing to S3

### Usage

```hcl
module "firehose_to_s3" {
  source = "..."
  account_id      = "your-account-id"
  firehose_name   = "my_name"
  bucket_name     = "my_bucket"
  buffer_size     = 5
  buffer_interval = 300
}
```

## Firehose Writer

[firehose_writer](./firehose_writer/)

```hcl
module "firehose_writer" {
  source = "..."
  role_name    = "existing-role-to-give-write-access"
  firehose_arn = "${module.firehose_to_s3.firehose_arn}"
}
```
