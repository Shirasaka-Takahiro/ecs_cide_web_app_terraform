output "ecr_repository_web_url" {
  value = aws_ecr_repository.default["web"].repository_url
}

output "ecr_repository_app_url" {
  value = aws_ecr_repository.default["app"].repository_url
}