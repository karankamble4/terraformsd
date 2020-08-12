
variable "azure_region" { }



variable "storageaccountname" { }

variable "rg"{

}

variable "sa_type" {
  default = "LRS"
}

variable "sa_tier" {
  default = "Standard"
}

variable "resource_tags" {
  type = map(string)
}

variable "assign_identity" {
  description = "Set to `true` to enable system-assigned managed identity, or `false` to disable it."
  default     = true
}

variable "enable_advanced_threat_protection" {
  description = "Boolean flag which controls if advanced threat protection is enabled."
  default     = false
}

variable "soft_delete_retention" {
  description = "Number of retention days for soft delete. If set to null it will disable soft delete all together."
  default     = 1
}

variable "network_rules" {
  description = "Network rules restricing access to the storage account."
  type        = object({ bypass = list(string), ip_rules = list(string), subnet_ids = list(string) })
  default     = null
}

variable "adlsv2_containers_list" {
  description = "List of adls v2 containers to create and their access levels."
  type        = list(object({ name = string, access_type = string, properties = map(string) }))
  default     = []
}

variable "lifecycles" {
  description = "Configure Azure Storage firewalls and virtual networks"
  type        = list(object({ prefix_match = set(string), tier_to_cool_after_days = number, tier_to_archive_after_days = number, delete_after_days = number, snapshot_delete_after_days = number }))
  default     = []
}
