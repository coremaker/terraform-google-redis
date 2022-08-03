resource "google_monitoring_alert_policy" "redis_memory_event" {
  count = var.enable_alerts ? 1 : 0

  display_name = "Redis Memory Alert"

  combiner              = "OR"
  notification_channels = var.alerts_type == "slack" ? [google_monitoring_notification_channel.redis_slack_channel.0.name] : google_monitoring_notification_channel.redis_email_channel.*.id

  conditions {
    display_name = "Redis instance has reached 75% MEMORY usage"
    condition_threshold {
      filter          = <<EOT
metric.type="redis.googleapis.com/stats/memory/usage_ratio" AND
resource.type="redis_instance"
EOT
      duration        = var.memory_events_alert_policy_threshold_duration
      threshold_value = "0.75"
      comparison      = "COMPARISON_GT"
      aggregations {
        alignment_period     = "60s"
        per_series_aligner   = "ALIGN_MAX"
        cross_series_reducer = "REDUCE_MEAN"
        group_by_fields      = ["project", "resource.label.instance_id"]
      }
    }
  }
  conditions {
    display_name = "Redis instance has reached 90% MEMORY usage"
    condition_threshold {
      filter          = <<EOT
metric.type="redis.googleapis.com/stats/memory/usage_ratio" AND
resource.type="redis_instance"
EOT
      duration        = var.memory_events_alert_policy_threshold_duration
      threshold_value = "0.9"
      comparison      = "COMPARISON_GT"
      aggregations {
        alignment_period     = "60s"
        per_series_aligner   = "ALIGN_MAX"
        cross_series_reducer = "REDUCE_MEAN"
        group_by_fields      = ["project", "resource.label.instance_id"]
      }
    }
  }
  lifecycle {
    create_before_destroy = true
  }
}

resource "google_monitoring_notification_channel" "redis_slack_channel" {
  count = var.enable_alerts && var.alerts_type == "slack" ? 1 : 0

  display_name = "Redis Slack Alert"
  type         = "slack"
  labels = {
    channel_name = var.alerts_slack_channel_name
  }

  sensitive_labels {
    auth_token = var.slack_auth_token
  }
}

resource "google_monitoring_notification_channel" "redis_email_channel" {
  count = var.enable_alerts && var.alerts_type == "email" ? length(var.alerts_email_address) : 0

  display_name = "Redis Email Alert for ${element(var.alerts_email_address, count.index)}"
  type         = "email"

  labels = {
    email_address = element(var.alerts_email_address, count.index)
  }
}
