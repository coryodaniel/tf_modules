resource "aws_elasticsearch_domain" "instance" {
  domain_name           = "${var.es_domain_name}"
  elasticsearch_version = "${var.es_version}"

  ebs_options {
    ebs_enabled = true
    volume_size = "${var.ebs_volume_size}"
    volume_type = "gp2"
  }

  cluster_config {
    instance_count = "${var.es_cluster_instance_count}"
    instance_type = "m4.large.elasticsearch"
    dedicated_master_enabled = "${var.es_cluster_master_count > 0}"
    dedicated_master_type = "${var.es_cluster_master_count > 0 ? "m4.large.elasticsearch" : ""}"
    dedicated_master_count = "${var.es_cluster_master_count}"
    zone_awareness_enabled = false
  }

  snapshot_options {
    automated_snapshot_start_hour = 23
  }

  access_policies = "${var.access_policies}"

  tags {
    terraform = true
  }
}
