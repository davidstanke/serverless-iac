data "archive_file" "source_zip" {
  type = "zip"
  source_dir = "src/${var.name}"
  output_path = "dist/${var.name}.zip"
}

resource "google_storage_bucket_object" "function_source" {
  name   = "functions/${var.name}.${data.archive_file.source_zip.output_sha}.zip"
  bucket = "${var.bucket}"
  source = "${data.archive_file.source_zip.output_path}"
}

resource "google_cloudfunctions_function" "function" {
  name   = "${var.name}"
  # available_memory_mb = 128
  source_archive_bucket = "${var.bucket}"
  source_archive_object = "${google_storage_bucket_object.function_source.name}"
  trigger_http = true
  # service_account_email = "${var.service_account_email}"
  project = "${var.project}"
  region = "${var.region}"
  runtime = "nodejs10"
  # timeout = 10
  entry_point = "${replace(var.name,"-","_")}"
  # environment_variables = "${var.environment_variables}"
  # update labels every deploy (to avoid "alreadyExists" errors)
  labels={updated="foo1"}
}