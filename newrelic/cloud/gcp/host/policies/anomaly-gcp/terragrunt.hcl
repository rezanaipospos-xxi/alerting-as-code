include {
    path = find_in_parent_folders()
}

terraform {
    source = "../../../../../../src/newrelic/alert-policy/"
}

inputs = {
    alert_policy_name = "GCP Host Anomaly"
    alert_policy_preference = "PER_CONDITION_AND_TARGET"
}