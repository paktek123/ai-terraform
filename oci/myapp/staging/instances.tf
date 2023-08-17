terraform {
  required_version = ">= 0.13"
  required_providers {
    oci = {
      version = ">= 4.0.0"
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
  source = "oracle-terraform-modules/compute-instance/oci"
  compartment_ocid = var.compartment_ocid
  freeform_tags    = var.freeform_tags
  defined_tags     = var.defined_tags
  ad_number                   = var.instance_ad_number
  instance_count              = var.instance_count
  instance_display_name       = var.instance_display_name
  instance_state              = var.instance_state
  shape                       = var.shape
  source_ocid                 = var.source_ocid
  source_type                 = var.source_type
  instance_flex_memory_in_gbs = var.instance_flex_memory_in_gbs
  instance_flex_ocpus         = 1
  baseline_ocpu_utilization   = var.baseline_ocpu_utilization
  cloud_agent_plugins = {
    autonomous_linux       = "ENABLED"
    bastion                = "ENABLED"
    vulnerability_scanning = "ENABLED"
    osms                   = "ENABLED"
    management             = "DISABLED"
    custom_logs            = "ENABLED"
    run_command            = "ENABLED"
    monitoring             = "ENABLED"
    block_volume_mgmt      = "DISABLED"
  }
  ssh_public_keys = var.ssh_public_keys
  public_ip            = var.public_ip
  subnet_ocids         = [oci_core_subnet.example_sub.id]
  primary_vnic_nsg_ids = [oci_core_network_security_group.example_nsg.id]
  boot_volume_backup_policy  = var.boot_volume_backup_policy
  block_storage_sizes_in_gbs = var.block_storage_sizes_in_gbs
}

output "instance_flex" {
  description = "ocid of created instances."
  value       = module.instance_flex.instances_summary
}

module "example_vcn" {
  source = "oracle-terraform-modules/vcn/oci"
  compartment_id = var.compartment_ocid
  lockdown_default_seclist = false
}

resource "oci_core_network_security_group" "example_nsg" {
  compartment_id = var.compartment_ocid
  vcn_id         = module.example_vcn.vcn_id
  display_name  = "NSG_example"
  freeform_tags = var.freeform_tags
}

resource "oci_core_subnet" "example_sub" {
  cidr_block     = "10.0.0.0/24"
  compartment_id = var.compartment_ocid
  vcn_id         = module.example_vcn.vcn_id
  display_name               = "example-sub"
  dns_label                  = "example"
  prohibit_public_ip_on_vnic = true
}

