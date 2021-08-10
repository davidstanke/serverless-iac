output "cloudrun-url" {
  value = google_cloud_run_service.myservice.status[0].url
}