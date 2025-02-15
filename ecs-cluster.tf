# resource "aws_ecr_repository" "ecr" {
#   name         = "yap-ecr"
#   force_delete = true
# }

module "ecs" {
  source  = "terraform-aws-modules/ecs/aws"
  version = "~> 5.9.0"

  cluster_name = "yap-cluster"

  fargate_capacity_providers = {
    FARGATE = {
      default_capacity_provider_strategy = {
        weight = 100
      }
    }
  }

  services = {
    yap-ecs-taskdef = {
      cpu    = 512
      memory = 1024

      #task_role_arn = "" # Add task role arn here

      # Container definition(s)
      container_definitions = {

        yap-flask-app = {
          essential = true
          image     = "255945442255.dkr.ecr.ap-southeast-1.amazonaws.com/yap-ecr:latest"
          port_mappings = [
            {
              containerPort = 8080
              protocol      = "tcp"
            }
          ]
        }
      }
      assign_public_ip                   = true
      deployment_minimum_healthy_percent = 100
      
      subnet_ids                         = data.aws_subnets.public.ids
      #subnet_ids                         = ["subnet-04f77fbdb492c4f2d", "subnet-06f367be1a47c378e", "subnet-0d611fc756355e58f"] #List of subnet IDs to use for your tasks
      security_group_ids                 = [aws_security_group.ecs-sg.id]                                                       #Create a SG resource and pass it here
    }
  }
}

