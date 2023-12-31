#Resource key pair
resource "aws_key_pair" "poc_key" {
  key_name      = "poc_key"
  public_key    = "${var.public_key_value}"
}

resource "aws_launch_configuration" "launch_config_webserver" {
  name   = "launch_config_webserver"
  image_id      = "${var.AMI}"
  instance_type = "${var.INSTANCE_TYPE}"
  user_data = "#!/bin/bash\napt-get update\napt-get -y install net-tools nginx\nMYIP=`ifconfig | grep -E '(inet 10)|(addr:10)' | awk '{ print $2 }' | cut -d ':' -f2`\necho 'Hello Team\nThis is my IP: '$MYIP > /var/www/html/index.html"
  security_groups = [aws_security_group.poc_webservers.id]
  associate_public_ip_address = true
  key_name = aws_key_pair.poc_key.key_name
  
  root_block_device {
    volume_type = "gp2"
    volume_size = "20"
  }
}

resource "aws_autoscaling_group" "poc_webserver" {
  name                      = "Poc_WebServers"
  max_size                  = 4
  min_size                  = 1
  health_check_grace_period = 30
  health_check_type         = "EC2"
  desired_capacity          = 2
  force_delete              = true
  launch_configuration      = aws_launch_configuration.launch_config_webserver.name
  vpc_zone_identifier       = ["${var.vpc_public_subnet1}", "${var.vpc_public_subnet2}"]
  target_group_arns         = [aws_lb_target_group.load-balancer-target-group.arn]
  enabled_metrics = [
    "GroupMinSize",
    "GroupMaxSize",
    "GroupDesiredCapacity",
    "GroupInServiceInstances",
    "GroupTotalInstances"
  ]
  metrics_granularity = "1Minute"
  lifecycle {
    ignore_changes = [desired_capacity]  
  }
}

resource "aws_autoscaling_policy" "web_policy_up" {
  name = "web_policy_up"
  scaling_adjustment = 1
  adjustment_type = "ChangeInCapacity"
  cooldown = 300
  autoscaling_group_name = aws_autoscaling_group.poc_webserver.name
}

resource "aws_cloudwatch_metric_alarm" "web_cpu_alarm_up" {
  alarm_name = "web_cpu_alarm_up"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods = "2"
  metric_name = "CPUUtilization"
  namespace = "AWS/EC2"
  period = "120"
  statistic = "Average"
  threshold = "60"

  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.poc_webserver.name
  }

  alarm_description = "This metric monitor EC2 instance CPU utilization"
  alarm_actions = [ aws_autoscaling_policy.web_policy_up.arn ]
}

resource "aws_autoscaling_policy" "web_policy_down" {
  name = "web_policy_down"
  scaling_adjustment = -1
  adjustment_type = "ChangeInCapacity"
  cooldown = 300
  autoscaling_group_name = aws_autoscaling_group.poc_webserver.name
}

resource "aws_cloudwatch_metric_alarm" "web_cpu_alarm_down" {
  alarm_name = "web_cpu_alarm_down"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods = "2"
  metric_name = "CPUUtilization"
  namespace = "AWS/EC2"
  period = "120"
  statistic = "Average"
  threshold = "10"

  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.poc_webserver.name
  }

  alarm_description = "This metric monitor EC2 instance CPU utilization"
  alarm_actions = [ aws_autoscaling_policy.web_policy_down.arn ]
}

#Application load balancer for app server
resource "aws_lb" "poc-load-balancer" {
  name               = "${var.ENVIRONMENT}-poc-lb"
  internal           = false
  load_balancer_type = "application"
  enable_cross_zone_load_balancing = true
  security_groups    = [aws_security_group.poc_webservers_alb.id]
  subnets            = ["${var.vpc_public_subnet1}", "${var.vpc_public_subnet2}"]
  depends_on         = [aws_autoscaling_group.poc_webserver]   

}

# Add Target Group
resource "aws_lb_target_group" "load-balancer-target-group" {
  name     = "load-balancer-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
}

# Adding HTTP listener
resource "aws_lb_listener" "webserver_listner" {
  load_balancer_arn = aws_lb.poc-load-balancer.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    target_group_arn = aws_lb_target_group.load-balancer-target-group.arn
    type             = "forward"
  }
}

output "load_balancer_output" {
  value = aws_lb.poc-load-balancer.dns_name
}
