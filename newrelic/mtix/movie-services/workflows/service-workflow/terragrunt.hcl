include {
    path = find_in_parent_folders()
}

terraform {
    source = "../../../../../src/newrelic/alert-workflow/"
}

dependency "slack-911-mtix-service" {
  config_path = "../../channels/slack/911-mtix-service"
}

dependency "service-anomaly" {
    config_path = "../../policies/service-anomaly"
}


inputs = {
    alert_workflow_name = "MTix Movie Service Workflow"
    alert_channel_id = dependency.slack-911-mtix-service.outputs.alert_channel_id
    alert_policy_channel_ids = [ dependency.service-anomaly.outputs.alert_policy_id]
}