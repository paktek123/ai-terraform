terraform {
  backend "s3" {
    bucket = "infra-tf-state"
    key = "terraform/myapp/dev/terraform.tfstate"
    region = "eu-central-1"
    role_arn = "arn:aws:iam::947865815790:role/atlantis_oci_terraform_role"
    encrypt = true
    dynamodb_table = "oci-lock"
    kms_key_id = "arn:aws:kms:eu-central-1:1111111111:key/xxxxxx-xxx-xxx-xxxx-xxxx"
  }

  required_providers {
      oci = {
        source  = "oracle/oci"
      }
    }
}

################################################################################

# providers
provider "oci" {}
