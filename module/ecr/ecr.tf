##ECR Repository
resource "aws_ecr_repository" "default" {
  for_each = { for ecr_repository_role in var.ecr_repository_role : ecr_repository_role => ecr_repository_role }

  name                 = "${var.general_config["project"]}-${var.general_config["env"]}-${each.value}-repository"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}

##AWS Account ID
data "aws_caller_identity" "self" {}

##Build up Dockerfile at the first terraform apply
resource "null_resource" "default" {
  for_each = { for docker_image_name in var.docker_image_name : docker_image_name => docker_image_name }

  provisioner "local-exec" {
    command = "aws ecr get-login-password --region ${var.region} | docker login --username AWS --password-stdin ${data.aws_caller_identity.self.account_id}.dkr.ecr.${var.region}.amazonaws.com"
  }

  provisioner "local-exec" {
    command = "docker tag ${each.value}:latest ${aws_ecr_repository.default[each.key].repository_url}:latest"
  }

  provisioner "local-exec" {
    command = "docker push ${aws_ecr_repository.default[each.key].repository_url}:latest"
  }
}