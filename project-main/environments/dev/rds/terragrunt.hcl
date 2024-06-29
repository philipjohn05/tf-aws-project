include {
  path = find_in_parent_folders()
}

terraform {
  source = "../../../modules//rds"
}

dependency "vpc" {
  config_path = "../vpc"
}

dependency "ec2" {
  config_path = "../ec2"
}

inputs = {
  vpc_id     = dependency.vpc.outputs.vpc_id
  subnet_id  = dependency.vpc.outputs.subnet_id
  web_sg_id  = dependency.ec2.outputs.web_sg_id
  db_username = "admin"
  db_password = "#PassSecure98"  #Use a secure method to manage passwords in production
}