variable "general_config" {
  type = map(any)
}
variable "ecr_repository_role" {
  type = list(string)
}
variable "region" {}
variable "docker_image_name" {
  type = list(string)
}