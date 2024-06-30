remote_state {
  backend = "s3"
  config = {
    bucket = "my-terraform-state-bucket-ap-southeast-1"
    key    = "${path_relative_to_include()}/terraform.tfstate"
    region = "ap-southeast-1"
  }
}

generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
provider "aws" {
  region = "ap-southeast-1"
}
EOF
}

# Consolidated locals block
locals {
  environment_vars = {
    dev = {
      vpc_cidr    = "10.0.0.0/16"
      subnet_cidr = "10.0.1.0/24"
    }
    prod = {
      vpc_cidr    = "172.16.0.0/16"
      subnet_cidr = "172.16.1.0/24"
    }
  }
  environment = reverse(split("/", path_relative_to_include()))[1]
}

# Expose the environment-specific variables
inputs = merge(
  {
    project     = "my-project"
    environment = local.environment
  },
  local.environment_vars[local.environment]
)