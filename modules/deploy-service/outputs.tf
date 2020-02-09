output "cloudrun-url" {
  value = split(",", join(",", google_cloud_run_service.myservice[*].status[0].url))
}