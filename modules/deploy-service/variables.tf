variable "project-id" {
  type=string
  description="Google Cloud Project ID"
}

variable "service-names" {
  type=list
  description="Name of the Cloud Run service to create"
}

variable "image-tag" {
  type=string
  description="container image tag to deploy"
}