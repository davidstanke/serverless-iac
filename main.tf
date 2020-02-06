provider "google" {
  project = var.project_id
}

module "deploy_service" {
  source = "./modules/deploy-service"
  image-tag = "var.image-tag"
  service-name = "onfirst"
}
