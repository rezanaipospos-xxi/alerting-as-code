variable "env_name" {}
variable "alert_channel_name" {}
variable "alert_channel_slack_id" {}

# Slack notification channel
resource "newrelic_notification_channel" "AlertChannel" {
  account_id = "your-newrelic-account-id"
  name = "${var.alert_channel_name}"
  type = "SLACK"
  destination_id = "{your-slack-destination-id}"
  product = "IINT"

  property {
    key = "channelId"
    value = "${var.alert_channel_slack_id}"
  }

  # property {
  #   key = "customDetailsSlack"
  #   value = "issue id - {{issueId}}"
  # }
}


output "alert_channel_id" {
  value = newrelic_notification_channel.AlertChannel.id
}