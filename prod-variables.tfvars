env = "prod"
#elb
elb_name                                = "web-elb"
vpc_id                                  = "vpc-8b7109f1"
instance_port                           = "8080"
instance_protocol                       = "https"
health_check_targetpath                 = "/index.html"
s3_name_for_access_logs                 = "im-srini-demo"
s3_enable_for_access_logs_true_or_false = "false"
#ec2
ec2_name  = "webserver"
ec2_count = "1"
ami_id    = "ami-0b69ea66ff7391e80"
