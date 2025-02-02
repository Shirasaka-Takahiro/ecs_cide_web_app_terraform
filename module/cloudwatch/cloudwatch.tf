##Cloudwatch Log Group
resource "aws_cloudwatch_log_group" "default" {
  for_each = { for ecs_prefix in var.ecs_prefix : ecs_prefix => ecs_prefix }

  name              = "/ecs/${var.general_config["project"]}/${var.general_config["env"]}/${each.value}"
  retention_in_days = 30
}