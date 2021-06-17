[![Maintained by coremaker.io](https://img.shields.io/badge/maintained%20by-coremaker.io-green)](https://coremaker.io/)

# Terraform Google Redis Module

This is a terraform module for GCP redis which helps you build a redis instance and set alerts.

# Outputs
All outputs are marked as sensitive and will not be shown on terraform plans.

* google_redis_instance_cache_host
* google_redis_instance_cache_port
* google_redis_instance_cache_id

# Examples

```terraform
module "redis" {
    source = "github.com/coremaker/terraform-google-redis.git"

    instance_authorized_network = google_compute_network_vpc_id
    instance_name = "prod"

    slack_auth_token = << token >>
}

resource "google_compute_network" "vpc" {
    name = "vpc"
    auto_create_subnetworks = false
}

resource "kubernetes_config_map" "redis_config" {
    metadata {
        name = "redis-config"
        namespace = "default"
    }

    data = {
        host = module.redis.google_redis_instance_cache_host
        port = module.redis.google_redis_instance_cache_port
    }
}
```