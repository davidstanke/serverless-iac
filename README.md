# demo of using Terraform to deploy serverless

#### To run applications locally:
_See individual applications under `src`_

#### To deploy from local:
`./deploy_from_local.sh`
_note: I don't think the TF backend is being correctly set to GCS remote when running from local. So probably don't do this_

#### To deploy via Cloud Build, triggered by gcloud w/ synthetic commit SHA
`gcloud builds submit --substitutions=SHORT_SHA=$(date "+%s"),_ENVIRONMENT_PREFIX=staging .`
