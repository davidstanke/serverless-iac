# zip up our source code
data "archive_file" "function_zip" {
 type        = "zip"
 source_file  = "src/${var.function-name}/main.py"
 output_path = "dist/${var.function-name}.zip"
}

locals {
  # append the hash of the function source to the archive name, to
  # force an update when the source changes
  function_source_hash = filesha256(data.archive_file.function_zip.output_path)
}

# place the zip-ed code in the bucket
resource "google_storage_bucket_object" "function_source" {
 name   = "${var.function-name}-${local.function_source_hash}.zip"
 bucket = var.functions-source-bucket
 source = data.archive_file.function_zip.output_path
}

resource "google_cloudfunctions_function" "myfunction" {

  name     = var.function-name
  runtime               = "python37"

  available_memory_mb   = 128
  source_archive_bucket = var.functions-source-bucket
  source_archive_object = google_storage_bucket_object.function_source.name
  entry_point           = var.function-name
  trigger_http          = true
}

# # IAM entry for all users to invoke the function
# resource "google_cloudfunctions_function_iam_member" "invoker" {
#   project        = google_cloudfunctions_function.myfunction.project
#   region         = google_cloudfunctions_function.myfunction.region
#   cloud_function = google_cloudfunctions_function.myfunction.name

#   role   = "roles/cloudfunctions.invoker"
#   member = "allUsers"
# }