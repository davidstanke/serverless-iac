resource "google_cloud_run_service" "service" {
  
  name     = "service"
  location = "us-central1"

  template {
    spec {
      containers {
        # image = "gcr.io/${var.project_id}/${var.service_names[count.index]}:${var.image_tag}"
        image = var.service-name
      }
    }
  }

  traffic {
    percent         = 100
    latest_revision = true
  }

}

# Public access for services
data "google_iam_policy" "noauth" {
  binding {
    role = "roles/run.invoker"
    members = [
      "allUsers",
    ]
  }
}

# Enable public access on Cloud Run service
resource "google_cloud_run_service_iam_policy" "allUsers" {
  location    = google_cloud_run_service.service.location
  project     = google_cloud_run_service.service.project
  service     = google_cloud_run_service.service.name
  policy_data = data.google_iam_policy.noauth.policy_data
}