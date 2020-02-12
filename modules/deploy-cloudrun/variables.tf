variable "project-id" {
  type=string
  description="Google Cloud Project ID"
}

variable "service-name" {
  type=string
  description="Name of the Cloud Run service to create"
}

variable "image-tag" {
  type=string
  description="container image tag to deploy"
}

variable "onFirstService" {
  type=string
}

variable "onSecondService" {
  type=string
}

variable "onThirdService" {
  type=string
}