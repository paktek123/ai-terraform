# Copyright (c) 2022 Oracle Corporation and/or affiliates.
# Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl/

# Resources

module "drg_hub" {
  source = "../../"

  # general oci parameters
  compartment_id = var.compartment_id
  label_prefix   = "prod"

  # drg parameters
  drg_display_name = var.drg_display_name
  drg_vcn_attachments = { for k, v in module.vcn_spokes : k => {
    vcn_id : v.vcn_id
    vcn_transit_routing_rt_id : null
    drg_route_table_id : null
    }
  }
}

module "vcn_spokes" {
  source = "github.com/oracle-terraform-modules/terraform-oci-vcn?ref=abcd1234" # replace with your specific commit hash

  for_each = var.vcn_spokes

  # general oci parameters
  compartment_id  = var.compartment_id
  label_prefix    = "prod"
  attached_drg_id = module.drg_hub.drg_id

  # vcn parameters
  create_internet_gateway  = each.value["create_internet_gateway"]  # boolean: true or false
  lockdown_default_seclist = each.value["lockdown_default_seclist"] # boolean: true or false
  create_nat_gateway       = each.value["create_nat_gateway"]       # boolean: true or false
  create_service_gateway   = each.value["create_service_gateway"]   # boolean: true or false
  enable_ipv6              = each.value["enable_ipv6"]              # boolean: true or false
  vcn_cidrs                = each.value["cidrs"]                    # List of IPv4 CIDRs
  vcn_dns_label            = each.value["dns_label"]                # string
  vcn_name                 = each.key                               # string
}
