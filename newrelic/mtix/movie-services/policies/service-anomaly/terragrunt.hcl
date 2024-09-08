include {
    path = find_in_parent_folders()
}

terraform {
    source = "../../../../../src/newrelic/alert-policy/"
}

inputs = {
    alert_policy_name = "MTix Movie Service Anomaly"
}