
include {
    path = find_in_parent_folders()
}

terraform {
    source = "../../../../../src/newrelic/alert-muting/"
}

inputs = {
  alert_muting_name                = "MTix Movie Service Muting"
  alert_muting_enable           = true
  alert_muting_desc       = ""
  alert_muting_start_time          = "2024-01-01T23:00:00"
  alert_muting_end_time            = "2024-01-02T09:30:00"
  alert_muting_time_zone           = "Asia/Jakarta"
  alert_muting_repeat              = "DAILY"
  alert_muting_weekly_repeat_days  = null
  alert_muting_repeat_count        = null
  alert_muting_conditions = [
    {
      attribute = "conditionName"
      operator  = "EQUALS"
      values    = ["Mtix Movie Low Apdex!!!"]
    },
    # Add more conditions as needed
  ]
}