
include {
    path = find_in_parent_folders()
}

terraform {
    source = "../../../../../../src/newrelic/alert-channel/"
}

inputs = {
    alert_channel_name = "{slack-channel-name}"
    alert_channel_slack_id = "{slack-channel-id}"
}