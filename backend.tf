terraform {
  backend "gcs" {
    bucket = "iac-for-serverless-tfstate"
    //    bucket  = "" #these will be passed as backend-config variables in the terraform init. See cloudbuild.yaml.
    //    project = ""
  }
}