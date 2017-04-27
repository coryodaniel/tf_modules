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

variable "s3_buffer_size" {
  description = "Firehose/S3 buffer size in MB (default 5 MB)"
  default = 5
}

variable "s3_buffer_interval" {
  description = "Firehose/S3 buffer interval in seconds (default 300 seconds)"
  default = 300
}

variable "es_domain_name" {
  description = "Name of the elasticsearch domain"
}

variable "es_version" {
  description = "The version of ElasticSearch to deploy (default 5.1)"
  default = "5.1"
}

variable "es_buffer_size" {
  description = "Firehose/ES buffer size in MB (default 5 MB)"
  default = 5
}

variable "es_buffer_interval" {
  description = "Firehose/ES buffer interval in seconds (default 300 seconds)"
  default = 300
}

variable "backup_all" {
  description = "Whether to backup all documents in S3 or only failed documents"
  default = true
}

variable "rotation_period" {
  description = "NoRotation, OneHour, OneDay, OneWeek, OneMonth (default OneDay)"
  default = "OneDay"
}

variable "es_index_name" {}
variable "ebs_volume_size" {
  description = "The size of EBS volumes attached to data nodes."
  default = "10"
}
variable "es_type_name" {}
variable "access_policies" {
  description = "IAM policy document specifying the access policies for the domain"
}

variable "es_cluster_master_count" {
  default = 0
}

variable "es_cluster_instance_count" {
  default = 1
}
