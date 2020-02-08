variable "project-id" {
  type = string
  # default="iac-for-serverless-staging"
}

variable "service-names" {
  type = list(string)
}

variable "image-tag" {
  type = string
}