output "google_redis_instance_cache_id" {
  value = google_redis_instance.cache.id
}

output "google_redis_instance_cache_host" {
  value     = google_redis_instance.cache.host
  sensitive = true
}

output "google_redis_instance_cache_port" {
  value     = google_redis_instance.cache.port
  sensitive = true
}
