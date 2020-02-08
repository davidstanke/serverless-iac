resource "google_cloud_run_service" "myservice" {
  
  name     = var.service-name
  location = "us-central1"

  template {
    # NOTE: several of these values are set to the default, but if they are omitted, 
    # TF will treat no-op `apply` runs as changes
    metadata {
      annotations = {
        "autoscaling.knative.dev/maxScale" = "1000"
      }
    }
    spec {
      container_concurrency = 80
      containers {
        # image = "gcr.io/${var.project_id}/${var.service_names[count.index]}:${var.image_tag}"
        image = "gcr.io/${var.project-id}/${var.service-name}:${var.image-tag}"
        resources {
          limits = {
            cpu = "1000m"
            memory = "256M"
          }
        }
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
  location    = google_cloud_run_service.myservice.location
  project     = google_cloud_run_service.myservice.project
  service     = google_cloud_run_service.myservice.name
  policy_data = data.google_iam_policy.noauth.policy_data
}