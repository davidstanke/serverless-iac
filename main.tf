provider "google" {
  project = var.project-id
}

module "deploy-service" {
  source = "./modules/deploy-service"
  image-tag = var.image-tag
  service-names = var.service-names
  project-id = var.project-id
}
