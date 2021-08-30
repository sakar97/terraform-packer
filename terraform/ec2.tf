provider "aws" {
  region = var.aws_region
  access_key = var.access_key
  secret_key = var.secret_key
}

#Create security group with firewall rules
resource "aws_security_group" "security_node" {
  name        = var.security_group
  description = "security group for nodejs"

  ingress {
    from_port   = 0
    to_port     = 6000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

 ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

 # outbound from jenkis server
  egress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags= {
    Name = var.security_group
  }
}

resource "aws_instance" "myFirstInstance" {
  ami           = data.aws_ami.ami.id 
  key_name = var.key_name
  instance_type = var.instance_type
  security_groups= [var.security_group]
  tags= {
    Name = var.tag_name
  }
}
# Create Elastic IP address
resource "aws_eip" "myFirstInstance" {
  vpc      = true
  instance = aws_instance.myFirstInstance.id
tags= {
    Name = "nodejs_elastic_ip"
  }
}
resource "aws_lb_target_group" "lb_target" {
  health_check {
    interval=10
    path="/"
    protocol="HTTP"
    timeout=5
    healthy_threshold=5
  }
  name = "my-test-lb"
  port = 3000
  protocol="HTTP"
  target_type = "instance"
  vpc_id = data.aws_vpc.selected.id

}
resource "aws_lb" "app_load_balancer" {
  name = "testing-lb"
  internal = false
  security_groups=[
    "${aws_security_group.security_node.id}"
  ]
  subnets = data.aws_subnet_ids.subnet_ids.ids
  ip_address_type = "ipv4"
  load_balancer_type = "application"
}
resource "aws_lb_listener" "lb_listener" {
  load_balancer_arn = aws_lb.app_load_balancer.arn
     port = 3000
     protocol = "HTTP"
     default_action {
       type="forward"
       target_group_arn="${aws_lb_target_group.lb_target.arn}"
     }
}
resource "aws_alb_target_group_attachment" "tg_attachment" {
  count = length(aws_instance.myFirstInstance)
  target_group_arn = aws_lb_target_group.lb_target.arn
  target_id = aws_instance.myFirstInstance.id
}
