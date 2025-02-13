resource "aws_ecs_cluster" "ecs_cluster" {
 name = "yap-flask-ecs-cluster"
}

# resource "aws_autoscaling_group" "ecs_asg" {
#  vpc_zone_identifier = [aws_subnet.subnet.id, aws_subnet.subnet2.id]
#  desired_capacity    = 2
#  max_size            = 3
#  min_size            = 1

#  launch_template {
#    id      = aws_launch_template.ecs_lt.id
#    version = "$Latest"
#  }

#  tag {
#    key                 = "AmazonECSManaged"
#    value               = true
#    propagate_at_launch = true
#  }
# }

resource "aws_ecs_capacity_provider" "ecs_capacity_provider" {
 name = "test1"

 auto_scaling_group_provider {
   auto_scaling_group_arn = aws_autoscaling_group.ecs_asg.arn

   managed_scaling {
     maximum_scaling_step_size = 1000
     minimum_scaling_step_size = 1
     status                    = "ENABLED"
     target_capacity           = 3
   }
 }
}