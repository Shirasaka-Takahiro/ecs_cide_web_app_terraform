output "cloudwatch_log_group_web_name" {
  value = aws_cloudwatch_log_group.default["web"].name
}

output "cloudwatch_log_group_app_name" {
  value = aws_cloudwatch_log_group.default["app"].name
}