variable "project-id" {
  type = string
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

variable "function-names" {
  type= list(string)
  default = [
    "experimental1",
  ]
}