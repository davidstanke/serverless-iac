terraform {
  backend "gcs" {
    bucket = "PROJECT_ID-tfstate"
    prefix = "terraform/state"
  }
}

provider "google" {
  project = var.project_id
}

resource "google_project_service" "run" {
  service = "run.googleapis.com"
}

resource "google_cloud_run_service" "default" {
  count = length(var.service_names)
  name     = var.service_names[count.index]
  location = "us-central1"

  template {
    spec {
      containers {
        image = "gcr.io/${var.project_id}/${var.service_names[count.index]}:${var.image_tag}"
      }
    }
  }

  traffic {
    percent         = 100
    latest_revision = true
  }

}

# output "url" {
#   value = "${google_cloud_run_service.default.status[0].url}"
# }

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
  count = length(var.service_names)
  location    = google_cloud_run_service.default[count.index].location
  project     = google_cloud_run_service.default[count.index].project
  service     = google_cloud_run_service.default[count.index].name
  policy_data = data.google_iam_policy.noauth.policy_data
}
