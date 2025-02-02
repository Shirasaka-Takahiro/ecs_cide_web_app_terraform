##Cluster
resource "aws_ecs_cluster" "cluster" {
  name = "${var.general_config["project"]}-${var.general_config["env"]}-cluster"

  setting {
    name  = "containerInsights"
    value = "disabled"
  }
}

##Task Definition
resource "aws_ecs_task_definition" "task" {
  family = "${var.general_config["project"]}-${var.general_config["env"]}-${var.task_role}-task"
  container_definitions = templatefile("${path.module}/container_definition.json",
    {
      project            = var.general_config["project"],
      env                = var.general_config["env"],
      task_role          = var.task_role,
      ecr_repository_url = var.ecr_repository_url
    }
  )
  cpu                = var.fargate_cpu
  memory             = var.fargate_memory
  network_mode       = "awsvpc"
  execution_role_arn = var.iam_ecs_arn

  requires_compatibilities = [
    "FARGATE"
  ]

}

##Service
resource "aws_ecs_service" "service" {
  name             = "${var.general_config["project"]}-${var.general_config["env"]}-${var.task_role}-service"
  cluster          = aws_ecs_cluster.cluster.id
  task_definition  = aws_ecs_task_definition.task.arn
  desired_count    = 2
  launch_type      = "FARGATE"
  platform_version = "1.4.0"

  load_balancer {
    target_group_arn = var.blue_tg_arn
    container_name   = "${var.general_config["project"]}-${var.general_config["env"]}-${var.task_role}-container"
    container_port   = "80"
  }

  network_configuration {
    subnets = var.dmz_subnet_ids
    security_groups = [
      var.internal_sg_id
    ]
    assign_public_ip = false
  }

  deployment_controller {
    type = "CODE_DEPLOY"
  }
}