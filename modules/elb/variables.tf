# ELB creation
#Declare the variables
variable "env" { }
variable "instance_type" {
  type="map"
  default = {
  dev = "t2.micro"
  prod = "t2.small"
  }
}
variable "vpc_id" { }
variable "ec2_name" { }
variable "ec2_count" {   default = "1" }
variable "ami_id" {}
variable "elb_name" { }
variable "instance_port" { }
variable "instance_protocol" { }
variable "health_check_targetpath" { }
variable "s3_name_for_access_logs" { }
variable "s3_enable_for_access_logs_true_or_false" { }

