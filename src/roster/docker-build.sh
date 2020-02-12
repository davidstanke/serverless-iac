#!/bin/sh

docker build -t gcr.io/$PROJECT_ID/roster:$(date +%s) \
  --build-arg SERVICE_ONFIRST='https://onfirst.doingdevops.com' \
  --build-arg SERVICE_ONSECOND='https://onsecond.doingdevops.com' \
  --build-arg SERVICE_ONTHIRD='https://onthird.doingdevops.com' \
  .