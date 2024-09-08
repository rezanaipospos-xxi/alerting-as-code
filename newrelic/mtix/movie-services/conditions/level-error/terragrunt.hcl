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
    alert_conditions_name = "Mtix Movie Service Error"
    alert_conditions_aggregation_window = 60
    alert_conditions_enable = false
    alert_conditions_aggregation_method = "event_timer"
    alert_conditions_aggregation_timer = 60 
    alert_conditions_aggregation_delay = null
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
SELECT COUNT(*) as 'total error' FROM Log Where entity.name = 'mtix-movie-services' and level = 'error' 
  EOF

    alert_conditions_warning = {
        #choose : above, above_or_equals, below, below_or_equals, equals, or not_equals
        operator              = "above"
        threshold             = 30
        threshold_duration    = 300
        #choose : all, at_least_once
        threshold_occurrences = "at_least_once" 
    }
      alert_conditions_critical = {
        #choose : above, above_or_equals, below, below_or_equals, equals, or not_equals
        operator              = "above"
        threshold             = 60
        threshold_duration    = 300
        #choose : all, at_least_once
        threshold_occurrences = "at_least_once" 
    }
  alert_conditions_expiration_duration = 300
  alert_conditions_close_violations_on_expiration = true
}
