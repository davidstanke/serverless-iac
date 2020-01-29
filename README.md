# demo of using Terraform to deploy serverless

#### To run applications locally:
[TODO]

#### To deploy from local:
`./deploy_from_local.sh`

#### To deploy via Cloud Build, triggered by gcloud w/ synthetic commit SHA
`gcloud builds submit --substitutions=SHORT_SHA=$(date "+%s")`