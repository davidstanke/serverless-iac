#!/bin/bash
set -euo pipefail

PROJECT_ID=$(gcloud config get-value project 2>/dev/null)

# get a unique id for the container (when running from SCM, we'll use the commit hash for this)
IMAGE_TAG=$(date +"%s")

# build docker container(s)
for service in onfirst onsecond onthird roster
do
  echo "building ${service}"
  docker build -t gcr.io/${PROJECT_ID}/${service}:${IMAGE_TAG} src/${service}
  docker push gcr.io/${PROJECT_ID}/${service}:${IMAGE_TAG}
done

# update cloud run services
echo "deploying services"
terraform apply -var image-tag=${IMAGE_TAG}