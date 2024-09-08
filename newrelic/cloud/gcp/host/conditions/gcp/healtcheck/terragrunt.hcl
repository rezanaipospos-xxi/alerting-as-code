include {
    path = find_in_parent_folders()
}

terraform {
    source = "../../../../../../../src/newrelic/alert-condition/nrql/"
}

dependency "policies-anomaly" {
  config_path = "../../../policies/anomaly-gcp"
}

inputs = {
    alert_policy_id = dependency.policies-anomaly.outputs.alert_policy_id
    alert_conditions_name = "GCP Host Down !!!"
    alert_conditions_aggregation_window = 60
    alert_conditions_enable = true
    alert_conditions_desc = <<EOF

*What to Do:*
```
1. Cek Console Compute Engine apakah running , 
   jika running tetapi masih belum bisa diakses.
   Coba cek pada Koneksi jaringan internet maupun firewall pada server

```


  EOF
    alert_conditions_runbook_url = "#"
    alert_conditions_query = <<EOF
      SELECT average(host.memoryUsedPercent) AS 'Memory used %' FROM Metric WHERE label.hostEnvironment = 'gcp' FACET hostname
  EOF

    alert_conditions_critical = {
        #choose : above, above_or_equals, below, below_or_equals, equals, or not_equals
        operator              = "equals"
        threshold             = 0
        threshold_duration    = 300
        #choose : all, at_least_once
        threshold_occurrences = "all" 
    }

    alert_conditions_expiration_duration = 600
    alert_conditions_open_violation_on_expiration = true


}
