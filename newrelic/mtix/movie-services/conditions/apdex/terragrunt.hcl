include {
    path = find_in_parent_folders()
}

terraform {
    source = "../../../../../src/newrelic/alert-condition/nrql/"
}

dependency "service-anomaly" {
  config_path = "../../policies/service-anomaly"
}

inputs = {
    alert_policy_id = dependency.service-anomaly.outputs.alert_policy_id
    alert_conditions_name = "Mtix Movie Low Apdex!!!"
    alert_conditions_aggregation_window = 60
    alert_conditions_enable = true
    alert_conditions_desc = <<EOF

*What to Do:*
```
1. Check log: https://{some=-newrelic-link}

```
tag who responsible:
<@your-slack-member-id>

  EOF
    alert_conditions_runbook_url = "#"
    alert_conditions_query = <<EOF
SELECT apdex(apm.service.apdex) as 'App server' FROM Metric WHERE (entity.guid = '{some-apm-id}')
  EOF

      alert_conditions_critical = {
        #choose : above, above_or_equals, below, below_or_equals, equals, or not_equals
        operator              = "below"
        threshold             = 0.7
        threshold_duration    = 300
        #choose : all, at_least_once
        threshold_occurrences = "all" 
    }
  alert_conditions_expiration_duration = 1800
  alert_conditions_open_violation_on_expiration = true
}
