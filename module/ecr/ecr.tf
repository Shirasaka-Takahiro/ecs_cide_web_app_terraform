##ECR Repository
resource "aws_ecr_repository" "default" {
  name                 = "${var.general_config["project"]}-${var.general_config["env"]}-${var.ecr_repository_role}-repository"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}

##AWS Account ID
data "aws_caller_identity" "self" {}

##Build up Dockerfile at the first terraform apply
resource "null_resource" "default" {
  provisioner "local-exec" {
    command = "aws ecr get-login-password --region ${var.region} | docker login --username AWS --password-stdin ${data.aws_caller_identity.self.account_id}.dkr.ecr.${var.region}.amazonaws.com"
  }

  provisioner "local-exec" {
    command = "docker tag ${var.docker_image_name}:latest ${aws_ecr_repository.default.repository_url}:latest"
  }

  provisioner "local-exec" {
    command = "docker push ${aws_ecr_repository.default.repository_url}:latest"
  }
}