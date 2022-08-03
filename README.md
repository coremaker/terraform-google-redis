[![Maintained by coremaker.io](https://img.shields.io/badge/maintained%20by-coremaker.io-green)](https://coremaker.io/)

# Terraform Google Redis Module

This is a terraform module for GCP redis which helps you build a redis instance and set alerts.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | n/a |
| <a name="provider_random"></a> [random](#provider\_random) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [google_monitoring_alert_policy.redis_memory_event](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/monitoring_alert_policy) | resource |
| [google_monitoring_notification_channel.redis_email_channel](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/monitoring_notification_channel) | resource |
| [google_monitoring_notification_channel.redis_slack_channel](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/monitoring_notification_channel) | resource |
| [google_project_service.redis](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_service) | resource |
| [google_redis_instance.cache](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/redis_instance) | resource |
| [random_string.redis_name](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_alerts_email_address"></a> [alerts\_email\_address](#input\_alerts\_email\_address) | n/a | `list(string)` | <pre>[<br>  "address@example.com"<br>]</pre> | no |
| <a name="input_alerts_slack_channel_name"></a> [alerts\_slack\_channel\_name](#input\_alerts\_slack\_channel\_name) | n/a | `string` | `"redis-alerts"` | no |
| <a name="input_alerts_type"></a> [alerts\_type](#input\_alerts\_type) | slack or email supported only | `string` | `"slack"` | no |
| <a name="input_enable_alerts"></a> [enable\_alerts](#input\_enable\_alerts) | Alerts | `bool` | `true` | no |
| <a name="input_instance_alternative_location_id"></a> [instance\_alternative\_location\_id](#input\_instance\_alternative\_location\_id) | n/a | `string` | `"europe-west2-b"` | no |
| <a name="input_instance_authorized_network"></a> [instance\_authorized\_network](#input\_instance\_authorized\_network) | Required | `string` | n/a | yes |
| <a name="input_instance_connect_mode"></a> [instance\_connect\_mode](#input\_instance\_connect\_mode) | n/a | `string` | `"PRIVATE_SERVICE_ACCESS"` | no |
| <a name="input_instance_location_id"></a> [instance\_location\_id](#input\_instance\_location\_id) | n/a | `string` | `"europe-west2-c"` | no |
| <a name="input_instance_memory_size"></a> [instance\_memory\_size](#input\_instance\_memory\_size) | n/a | `number` | `1` | no |
| <a name="input_instance_name"></a> [instance\_name](#input\_instance\_name) | n/a | `string` | `"dev"` | no |
| <a name="input_instance_tier"></a> [instance\_tier](#input\_instance\_tier) | Defaults | `string` | `"STANDARD_HA"` | no |
| <a name="input_instance_version"></a> [instance\_version](#input\_instance\_version) | n/a | `string` | `"REDIS_4_0"` | no |
| <a name="input_memory_events_alert_policy_threshold_duration"></a> [memory\_events\_alert\_policy\_threshold\_duration](#input\_memory\_events\_alert\_policy\_threshold\_duration) | n/a | `string` | `"900s"` | no |
| <a name="input_read_replicas_mode"></a> [read\_replicas\_mode](#input\_read\_replicas\_mode) | Read replicas mode. https://cloud.google.com/memorystore/docs/redis/reference/rest/v1/projects.locations.instances#readreplicasmode | `string` | `"READ_REPLICAS_DISABLED"` | no |
| <a name="input_redis_configs"></a> [redis\_configs](#input\_redis\_configs) | The Redis configuration parameters. See [more details](https://cloud.google.com/memorystore/docs/redis/reference/rest/v1/projects.locations.instances#Instance.FIELDS.redis_configs) | `map(any)` | `{}` | no |
| <a name="input_replica_count"></a> [replica\_count](#input\_replica\_count) | The number of replicas. can | `number` | `null` | no |
| <a name="input_slack_auth_token"></a> [slack\_auth\_token](#input\_slack\_auth\_token) | n/a | `string` | `"token"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_google_redis_instance_cache_host"></a> [google\_redis\_instance\_cache\_host](#output\_google\_redis\_instance\_cache\_host) | n/a |
| <a name="output_google_redis_instance_cache_id"></a> [google\_redis\_instance\_cache\_id](#output\_google\_redis\_instance\_cache\_id) | n/a |
| <a name="output_google_redis_instance_cache_port"></a> [google\_redis\_instance\_cache\_port](#output\_google\_redis\_instance\_cache\_port) | n/a |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

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