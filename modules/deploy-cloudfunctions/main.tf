resource "google_cloudfunctions_function" "myfunction" {
  
  count    = length(var.function-names)
  name     = var.function-names[count.index]
  project  = var.project-id
  location = "us-central1"

  

}

// # Public access for services
// data "google_iam_policy" "noauth" {
//   binding {
//     role = "roles/run.invoker"
//     members = [
//       "allUsers",
//     ]
//   }
// }

// # Enable public access on Cloud Run service
// resource "google_cloud_run_service_iam_policy" "allUsers" {
//   count    = length(var.service-names)
//   location    = google_cloud_run_service.myservice[count.index].location
//   project     = google_cloud_run_service.myservice[count.index].project
//   service     = google_cloud_run_service.myservice[count.index].name
//   policy_data = data.google_iam_policy.noauth.policy_data
// }