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