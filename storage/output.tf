output "storage_account_id" {
  description = "The ID of the storage account."
  value       = azurerm_storage_account.storageacc.id
}

output "storage_account_name" {
  description = "The name of the storage account."
  value       = azurerm_storage_account.storageacc.name
}

output "storage_primary_access_key" {
  description = "The primary access key for the storage account."
  value       = azurerm_storage_account.storageacc.primary_access_key
  sensitive   = true
}

output "storage_secondary_access_key" {
  description = "The primary access key for the storage account."
  value       = azurerm_storage_account.storageacc.secondary_access_key
  sensitive   = true
}

output "adls_containers" {
  description = "Map of adls containers."
  value       = { for c in azurerm_storage_data_lake_gen2_filesystem.containers : c.name => c.id }
}
