provider "aws" {
  region = "us-east-1"
}


module "elb_dev" {
  source                                  = "./modules/elb"
  env                                     = "${var.env}"
  elb_name                                = "${var.elb_name}"
  vpc_id                                  = "${var.vpc_id}"
  ec2_name                                = "${var.ec2_name}"
  ec2_count                               = "${var.ec2_count}"
  ami_id                                  = "${var.ami_id}"
  instance_port                           = "${var.instance_port}"
  instance_protocol                       = "${var.instance_protocol}"
  health_check_targetpath                 = "${var.health_check_targetpath}"
  s3_enable_for_access_logs_true_or_false = "${var.s3_enable_for_access_logs_true_or_false}"
  s3_name_for_access_logs                 = "${var.s3_name_for_access_logs}"
}

module "elb_prod" {
  source                                  = "./modules/elb"
  env                                     = "${var.env}"
  elb_name                                = "${var.elb_name}"
  vpc_id                                  = "${var.vpc_id}"
  ec2_name                                = "${var.ec2_name}"
  ec2_count                               = "${var.ec2_count}"
  ami_id                                  = "${var.ami_id}"
  instance_port                           = "${var.instance_port}"
  instance_protocol                       = "${var.instance_protocol}"
  health_check_targetpath                 = "${var.health_check_targetpath}"
  s3_enable_for_access_logs_true_or_false = "${var.s3_enable_for_access_logs_true_or_false}"
  s3_name_for_access_logs                 = "${var.s3_name_for_access_logs}"
}

terraform {
  backend "s3" {
    bucket = "im-srini-demo"
    key    = "elb.tfstate"
    region = "us-east-1"
	dynamodb_table ="terraform-demo"
  }
}

#/d/2019/Terraform/terraform init  -target=module.elb_dev  -var-file="dev-variables.tfvars"
#/d/2019/Terraform/terraform apply  -target=module.elb_dev  -var-file="dev-variables.tfvars" --auto-approve

#/d/2019/Terraform/terraform apply  -target=module.elb_prod  -var-file="prod-variables.tfvars" --auto-approve