#!/bin/bash
set -euo pipefail

PROJECT_ID=$(gcloud config get-value project)
BUCKET=${PROJECT_ID}-terraform-config
REGION="us-central1"

terraform init -backend-config="bucket=${BUCKET}" -backend-config="prefix=terraform/state" -backend-config="project=${PROJECT_ID}" -backend-config="credentials=credentials.json" terraform

for function_name in onFirst
do
    terraform apply -auto-approve -var project=${PROJECT_ID} -var bucket=${BUCKET} -var region=${REGION} -var name=$function_name terraform
done