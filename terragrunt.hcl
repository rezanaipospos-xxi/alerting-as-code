locals {
    env_name = path_relative_to_include()
}

inputs = {
    env_name = local.env_name
}

remote_state {
    backend = "gcs"
    generate = {
        path = "backend.tf"
        if_exists = "overwrite_terragrunt"
    }
    config = {
        project = "your-project-id"
        bucket  = "alerting-as-code" # Google Cloud Storage bucket required
        prefix  = "${local.env_name}/terraform.tfstate" # Path to the state file in the bucket
        location = "asia-southeast1"
        impersonate_service_account = "{name-of-sa}@{projectid}.iam.gserviceaccount.com"
    }
}