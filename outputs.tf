output "cloud_run_endpoint" {
  value = module.deploy-cloudrun.output.cloudrun-url
}