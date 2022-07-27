resource "google_redis_instance" "cache" {
  name           = "redis-${var.instance_name}-${random_string.redis_name.result}"
  tier           = var.instance_tier
  replica_count      = var.instance_tier == "STANDARD_HA" ? var.replica_count : null
  read_replicas_mode = var.instance_tier == "STANDARD_HA" ? var.read_replicas_mode : null
  memory_size_gb = var.instance_memory_size

  location_id             = var.instance_location_id
  alternative_location_id = var.instance_alternative_location_id

  authorized_network = var.instance_authorized_network
  connect_mode       = var.instance_connect_mode

  redis_version     = var.instance_version
  redis_configs     = var.redis_configs
  display_name      = "Redis-${var.instance_name}"

  depends_on = [google_project_service.redis]
}

resource "google_project_service" "redis" {
  service = "redis.googleapis.com"
}