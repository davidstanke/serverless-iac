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

module "deploy-cloudfunctions" {
  source ="./modules/deploy-cloudfunctions"
  function-name = "experimental1"
  function-version = "1001"
  functions-source-bucket="${var.project-id}-functions-source"
}

output "experimental1_url" {
  value = module.deploy-cloudfunctions.cloudfunction-url
}