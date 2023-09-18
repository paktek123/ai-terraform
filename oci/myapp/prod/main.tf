terraform {
  required_providers {
    oci = {
      source  = "hashicorp/oci"
      version = "4.0.0"
    }
  }
}

provider "oci" {
  tenancy_ocid     = var.tenancy_ocid
  user_ocid        = var.user_ocid
  fingerprint      = var.fingerprint
  private_key_path = var.private_key_path
  region           = var.region
}

module "instance_flex" {
  source = "oracle-terraform-modules/compute-instance/oci?ref=123456789abcdefg" // replace with actual commit hash
  version = "1.0.0"
  compartment_ocid = var.compartment_ocid
  freeform_tags    = var.freeform_tags
  defined_tags     = var.defined_tags
  ad_number        = var.instance_ad_number
  instance_count   = var.instance_count
  instance_display_name = var.instance_display_name
  instance_state   = var.instance_state
  shape            = var.shape
  source_ocid      = var.source_ocid
  source_type      = var.source_type
  instance_flex_memory_in_gbs = var.instance_flex_memory_in_gbs
  instance_flex_ocpus = var.instance_flex_ocpus
  baseline_ocpu_utilization = var.baseline_ocpu_utilization
  ssh_public_keys  = var.ssh_public_keys
  public_ip        = var.public_ip
  subnet_ocids     = var.subnet_ocids
  primary_vnic_nsg_ids = var.primary_vnic_nsg_ids
  boot_volume_backup_policy = var.boot_volume_backup_policy
  block_storage_sizes_in_gbs = var.block_storage_sizes_in_gbs
}

output "instance_flex" {
  description = "ocid of created instances."
  value       = module.instance_flex.instances_summary
}
