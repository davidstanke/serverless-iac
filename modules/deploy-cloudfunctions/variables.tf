variable "project-id" {
  type=string
  description="Google Cloud Project ID"
}

variable "function-names" {
  type=list
  description="Name of the Google Cloud Functions services to create"
}

variable "timestamp" {
  type=string
}