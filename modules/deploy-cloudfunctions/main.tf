# zip up our source code
data "archive_file" "hello_world_zip" {
 type        = "zip"
 source_dir  = "src/${var.function-name}/"
 output_path = "dist/${var.function-name}-${var.function-version}.zip"
}

# create the storage bucket
resource "google_storage_bucket" "functions_source_bucket" {
 name   = "functions_source_bucket"
}

# place the zip-ed code in the bucket
resource "google_storage_bucket_object" "function_source" {
 name   = "${var.function-name}.zip"
 bucket = google_storage_bucket.functions_source_bucket.name
 source = "dist/${var.function-name}-${var.function-version}.zip"
}

resource "google_cloudfunctions_function" "myfunction" {

  name     = var.function-name
  project  = var.project-id
  available_memory_mb   = 256
  source_archive_bucket = google_storage_bucket.functions_source_bucket.name
  source_archive_object = google_storage_bucket_object.function_source.name
  timeout               = 60
  entry_point           = var.function-name
  trigger_http          = true
  runtime               = "node12"
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