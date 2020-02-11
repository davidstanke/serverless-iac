provider "google" {
  project = var.project-id
}

module "deploy-cloudrun" {
  source = "./modules/deploy-cloudrun"
  image-tag = var.image-tag
  service-names = var.service-names
  project-id = var.project-id
}
