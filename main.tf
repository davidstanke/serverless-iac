provider "google" {
  project = var.project-id
  region = "us-central1"
}

# module "deploy-cloudrun" {
#   source = "./modules/deploy-cloudrun"
#   image-tag = var.image-tag
#   service-names = var.service-names
#   project-id = var.project-id
# }

resource "google_storage_bucket" "bucket" {
  name = "${var.project-id}-functions-source"
}

module "deploy-cloudfunction-onfirst" {
  source ="./modules/deploy-cloudfunctions-node"
  function-name = "onfirst"
  functions-source-bucket=google_storage_bucket.bucket.name
}

module "deploy-cloudfunction-onsecond" {
  source ="./modules/deploy-cloudfunctions-node"
  function-name = "onsecond"
  functions-source-bucket=google_storage_bucket.bucket.name
}

module "deploy-cloudfunction-onthird" {
  source ="./modules/deploy-cloudfunctions-python"
  function-name = "onthird"
  functions-source-bucket=google_storage_bucket.bucket.name
}

# deploy 'roster' service as Cloud Run
# module "deploy-cloudrun" {
#   source = "./modules/deploy-cloudrun"
#   project-id = var.project-id
#   image-tag = var.image-tag
#   service-name = "roster"
#   onFirstService = module.deploy-cloudfunction-onfirst.cloudfunction-url
#   onSecondService = module.deploy-cloudfunction-onsecond.cloudfunction-url
#   onThirdService = module.deploy-cloudfunction-onthird.cloudfunction-url
# }