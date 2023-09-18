terraform {
  required_providers {
    oci = {
      source  = "oracle-terraform-modules/oke/oci"
      version = "4.0.3"
    }
  }
}
module "oke" {
   source  = "oracle-terraform-modules/oke/oci?ref=abcd1234" // replace "commit_hash" with a specific commit hash
 
   home_region = var.verrazzano_regions["home"]
   region      = var.verrazzano_regions["v8o"]
 
   tenancy_id = var.tenancy_id
 
   # general oci parameters
   compartment_id = var.compartment_id
   label_prefix   = "prod"
 
   # ssh keys
   ssh_private_key_path = "~/.ssh/id_rsa"
   ssh_public_key_path  = "~/.ssh/id_rsa.pub"
 
   # networking
   create_drg                   = true
   internet_gateway_route_rules = []
   nat_gateway_route_rules      = []
 
   vcn_cidrs     = ["10.0.0.0/16"]
   vcn_dns_label = "v8o"
   vcn_name      = "v8o"
 
   # bastion host
   create_bastion_host = true
   upgrade_bastion     = false
 
   # operator host
   create_operator                    = true
   enable_operator_instance_principal = true
   upgrade_operator                   = false
 
   # oke cluster options
   cluster_name                = "v8o"
   control_plane_type          = "private"
   control_plane_allowed_cidrs = ["0.0.0.0/0"]
   kubernetes_version          = "v1.21.5"
   pods_cidr                   = "10.244.0.0/16"
   services_cidr               = "10.96.0.0/16"
 
   # node pools
   node_pools = {
     np1 = { shape = "VM.Standard.E4.Flex", ocpus = 2, memory = 32, node_pool_size = 2, boot_volume_size = 150, label = { app = "frontend", pool = "np1" } }
   }
   node_pool_name_prefix = "v8o"
 
   # oke load balancers
   load_balancers          = "both"
   preferred_load_balancer = "public"
   public_lb_allowed_cidrs = ["0.0.0.0/0"]
   public_lb_allowed_ports = [80, 443]
 
   # freeform_tags
   freeform_tags = {
     vcn = {
       verrazzano = "prod"
     }
     bastion = {
       access     = "public",
       role       = "bastion",
       security   = "high"
       verrazzano = "prod"
     }
     operator = {
       access     = "restricted",
       role       = "operator",
       security   = "high"
       verrazzano = "prod"
     }
     oke = {
       cluster = {
         environment = "prod"
         role        = "cluster"
       }
       service_lb = {
         environment = "prod"
         role        = "load balancer"
       }
       node_pool = {
         environment = "prod"
         role        = "node-pool"
       }
     }
   }
 
   providers = {
     oci.home = oci.home
   }
 }
