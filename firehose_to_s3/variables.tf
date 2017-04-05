variable "account_id"{
  description = "Your AWS Account ID"
}

variable "firehose_name" {
  description = "Firehose name to be created"
}

variable "bucket_name" {
  description = "S3 bucket name to be created"
}

variable "force_destroy_bucket" {
  description = "Force destroy the bucket on `terraform destroy`. Objects not recoverable"
  default = false
}

variable "buffer_size" {
  description = "Firehose/S3 buffer size in MB (default 5 MB)"
  default = 5
}

variable "buffer_interval" {
  description = "Firehose/S3 buffer interval in seconds (default 300 seconds)"
  default = 300
}
