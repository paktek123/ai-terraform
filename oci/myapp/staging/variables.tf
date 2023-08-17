# Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl

# OCI Provider parameters
variable "api_fingerprint" {
  default     = ""
  description = "Fingerprint of the API private key to use with OCI API."
  type        = string
}

variable "api_private_key_path" {
  default     = ""
  description = "The path to the OCI API private key."
  type        = string
}

variable "verrazzano_regions" {
  description = "A map Verrazzano regions."
  type        = map(string)
}

variable "tenancy_id" {
  description = "The tenancy id of the OCI Cloud Account in which to create the resources."
  type        = string
}

variable "user_id" {
  description = "The id of the user that terraform will use to create the resources."
  type        = string
  default     = ""
}

# General OCI parameters
variable "compartment_id" {
  description = "The compartment id where to create all resources."
  type        = string
}

variable "label_prefix" {
  default     = "none"
  description = "A string that will be prepended to all resources."
  type        = string
}

# ssh keys
variable "ssh_private_key_path" {
  default     = "none"
  description = "The path to ssh private key."
  type        = string
}

variable "ssh_public_key_path" {
  default     = "none"
  description = "The path to ssh public key."
  type        = string
}

# Verrrazzano parameters

variable "verrazzano_version" {
  default     = "1.0.3"
  description = "Version of Verrazzano release to install"
  type        = string
}

variable "verrazzano_name" {
  default     = "v8o"
  description = "Name of Verrazzano resource"
  type        = string
}

# Copyright (c) 2022 Oracle Corporation and/or affiliates.
# Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl

# provider identity parameters
variable "api_fingerprint" {
  description = "fingerprint of oci api private key"
  type        = string
}

variable "api_private_key_path" {
  description = "path to oci api private key used"
  type        = string
}

variable "region" {
  description = "the oci region where resources will be created"
  type        = string
}

variable "tenancy_id" {
  description = "tenancy id where to create the sources"
  type        = string
}

variable "user_id" {
  description = "id of user that terraform will use to create the resources"
  type        = string
}

# general oci parameters

variable "compartment_id" {
  description = "compartment id where to create all resources"
  type        = string
}

variable "label_prefix" {
  description = "a string that will be prepended to all resources"
  type        = string
  default     = "terraform-oci"
}

# drg parameters

variable "drg_display_name" {
  description = "(Updatable) Name of Dynamic Routing Gateway. Does not have to be unique."
  type        = string
  default     = "drg_hub"
}

# vcn parameters

variable "vcn_spokes" {
  type = map(any)
  default = {
    vcn_spoke1 = {
      cidrs                    = ["10.0.1.0/24", "10.0.2.0/24"]
      dns_label                = "spoke1"
      create_internet_gateway  = false
      create_nat_gateway       = true
      create_service_gateway   = false
      enable_ipv6              = true
      lockdown_default_seclist = true
    }
    vcn_spoke2 = {
      cidrs                    = ["10.0.3.0/24"]
      dns_label                = "spoke2"
      create_internet_gateway  = true
      create_nat_gateway       = false
      create_service_gateway   = false
      enable_ipv6              = false
      lockdown_default_seclist = true
    }
  }
}

