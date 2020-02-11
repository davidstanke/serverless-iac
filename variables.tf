variable "project-id" {
  type = string
  # default="iac-for-serverless-staging"
}

variable "service-names" {
  type = list(string)
  default = [
    "onfirst",
    "onsecond",
    "onthird",
    "roster",
  ]
}

variable "image-tag" {
  type = string
}