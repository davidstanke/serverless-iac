provider "google" {
  project = var.project-id
}

module "deploy_service" {
  source = "./modules/deploy-service"
  image-tag = var.image-tag
  service-name = var.service-name
  project-id = var.project-id
}
