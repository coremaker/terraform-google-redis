# Required
variable "instance_authorized_network" {
}

# Defaults
variable "instance_tier" {
    type = string
    default = "STANDARD_HA"
}

variable "instance_version" {
    type = string
    default = "REDIS_4_0"
}

variable "instance_memory_size" {
    type = number
    default = 1
}

variable "instance_name" {
    type = string
    default = "dev"
}

variable "instance_location_id" {
    type = string
    default = "europe-west2-c"
}

variable "instance_alternative_location_id" {
    type = string
    default = "europe-west2-b"
}

variable "instance_connect_mode" {
    type = string
    default = "PRIVATE_SERVICE_ACCESS"
}

variable "redis_configs" {
  description = "The Redis configuration parameters. See [more details](https://cloud.google.com/memorystore/docs/redis/reference/rest/v1/projects.locations.instances#Instance.FIELDS.redis_configs)"
  type        = map(any)
  default     = {}
}

variable "replica_count" {
  description = "The number of replicas. can"
  type        = number
  default     = null
}

variable "read_replicas_mode" {
  description = "Read replicas mode. https://cloud.google.com/memorystore/docs/redis/reference/rest/v1/projects.locations.instances#readreplicasmode "
  type        = string
  default     = "READ_REPLICAS_DISABLED"
}

# Alerts
variable "enable_alerts" {
    type = bool
    default = true
}

# slack or email supported only
variable "alerts_type" {
    type = string
    default = "slack"
}

variable "alerts_email_address" {
    type = list(string)
    default = ["address@example.com"]
}

variable "slack_auth_token" {
    default = "token" # Needs to be replaced with a working token
}

variable "alerts_slack_channel_name" {
    type = string
    default = "redis-alerts"
}

variable "memory_events_alert_policy_threshold_duration" {
    type = string
    default = "900s"
}