remote_state {
  backend = "s3"
  config = {
    bucket = "my-terraform-state-bucket"
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
