##Cloudwatch Log Group
resource "aws_cloudwatch_log_group" "deafult" {
  name              = "/ecs/${var.general_config["project"]}/${var.general_config["env"]}/${var.task_role}"
  retention_in_days = 30
}