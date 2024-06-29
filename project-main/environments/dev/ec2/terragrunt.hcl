include {
  path = find_in_parent_folders()
}

terraform {
  source = "../../../modules//ec2"
}

dependency "vpc" {
  config_path = "../vpc"
}

inputs = {
  vpc_id    = dependency.vpc.outputs.vpc_id
  subnet_id = dependency.vpc.outputs.subnet_id
  ami_id    = "ami-01dca6b685b1c23b7"  #Amazon Linux 2 AMI in ap-southeast-1
}