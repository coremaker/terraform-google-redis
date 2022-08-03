resource "random_string" "redis_name" {
  length  = 4
  special = false
  upper   = false

  lifecycle {
    ignore_changes = all
  }
}
