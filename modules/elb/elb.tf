# ELB creation
#Declare the data source
data "aws_vpc" "selected" {
  id = "${var.vpc_id}"
}
data "aws_availability_zones" "azs" {
  state = "available"
}

data "aws_subnet_ids" "subnetslist" {
  vpc_id = "${data.aws_vpc.selected.id}"
}

resource "aws_instance" "getec2" {
  count         = "${var.ec2_count}"
  ami           = "${var.ami_id}"
  instance_type = "${lookup(var.instance_type,var.env)}"
  availability_zone       = "${data.aws_availability_zones.azs.names[count.index]}"
  tags ={
    Name = "${var.env}-${var.ec2_name}-${count.index +1}"
	Env = "${var.env}"
  }
}


resource "aws_elb" "web" {
  name               = "${var.env}-${var.elb_name}"
  availability_zones = "${data.aws_availability_zones.azs.names}"

  listener {
    instance_port     = "${var.instance_port}"
    instance_protocol = "${var.instance_protocol}"
    lb_port           = 80
    lb_protocol       = "http"
  }
  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "${var.instance_protocol}:${var.instance_port}${var.health_check_targetpath}"
    interval            = 30
  }

  access_logs {
    bucket        = "${var.s3_name_for_access_logs}"
    bucket_prefix = "${var.env}-${var.elb_name}"
    interval      = 60
	enabled       = "${var.s3_enable_for_access_logs_true_or_false}"
  }
  instances  = "${aws_instance.getec2.*.id}"
  cross_zone_load_balancing   = true
  idle_timeout                = 400
  connection_draining         = true
  connection_draining_timeout = 400

  tags = {
    Name = "${var.env}-${var.elb_name}"
  }
}

