provider "google" {
  project = var.project-id
}

module "onfirst" {
  source = "./modules/deploy-service"
  count = length(service-names)
  image-tag = var.image-tag
  service-name = var.service-name
  project-id = var.project-id
}
