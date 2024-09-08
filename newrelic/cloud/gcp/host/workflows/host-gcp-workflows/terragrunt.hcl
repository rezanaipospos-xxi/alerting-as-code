include {
    path = find_in_parent_folders()
}

terraform {
    source = "../../../../../../src/newrelic/alert-workflow/"
}

dependency "slack-911-infra-gcp" {
  config_path = "../../channels/slack/911-infra-gcp"
}

dependency "policies-anomaly" {
    config_path = "../../policies/anomaly-gcp"
}

inputs = {
    alert_workflow_name = "GCP Host Workflow"
    alert_channel_id = dependency.slack-911-infra-gcp.outputs.alert_channel_id
    alert_policy_channel_ids = [ dependency.policies-anomaly.outputs.alert_policy_id]
}