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
  source = "github.com/coryodaniel/tf_modules//firehose_to_s3"
  account_id      = "your-account-id"
  firehose_name   = "my_name"
  bucket_name     = "my_bucket"
  buffer_size     = 5
  buffer_interval = 300
}
```

## Firehose Writer

[firehose_writer](./firehose_writer/) will create the write policy for Firehose and attaches it to the given role.

This module will create:
* [IAM Policy](./firehose_writer/iam.tf) for writing to the firehose
* Attachment to the `role_name` provided. This role should already exist.

```hcl
module "firehose_writer" {
  source = "github.com/coryodaniel/tf_modules//firehose_writer"
  role_name    = "existing-role-to-give-write-access"
  firehose_arn = "${module.firehose_to_s3.firehose_arn}"
}
```
