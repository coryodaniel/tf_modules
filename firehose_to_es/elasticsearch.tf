resource "aws_elasticsearch_domain" "instance" {
  domain_name           = "${var.es_domain_name}"
  elasticsearch_version = "${var.es_version}"

  ebs_options{
    ebs_enabled = true
    volume_size = "${var.ebs_volume_size}"
    volume_type = "gp2"
  }

  snapshot_options {
    automated_snapshot_start_hour = 23
  }

  access_policies = "${var.access_policies}"

  tags {
    terraform = true
  }
}
