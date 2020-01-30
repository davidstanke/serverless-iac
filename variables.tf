variable "project_id" {
  type = string
  default="iac-for-serverless-staging"
}

variable "service_names" {
  type = list(string)
  default=["onfirst","onsecond","onthird","roster"]
}

variable "image_tag" {
  type = string
  default = "test"
}