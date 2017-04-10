resource "aws_elasticsearch_domain" "instance" {
  domain_name           = "${var.es_domain_name}"
  elasticsearch_version = "${var.es_version}"

  ebs_options{
    ebs_enabled = false
  }

  snapshot_options {
    automated_snapshot_start_hour = 23
  }

  tags {
    terraform = true
  }
}
