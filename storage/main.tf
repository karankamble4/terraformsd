

resource "azurerm_storage_account" "storageacc" {
  name                     = var.storageaccountname
  resource_group_name      = var.rg
  location                 = var.azure_region
  account_tier             = var.sa_tier
  account_replication_type = var.sa_type
  account_kind             = "StorageV2"
  is_hns_enabled           = "true"
  tags                     = var.resource_tags

  # allow_blob_public_access = "false"
  identity {
    type = var.assign_identity ? "SystemAssigned" : null
  }

 
  dynamic "network_rules" {
    for_each = var.network_rules != null ? ["true"] : []
    content {
      default_action             = "Deny"
      bypass                     = var.network_rules.bypass
      ip_rules                   = var.network_rules.ip_rules
      virtual_network_subnet_ids = var.network_rules.subnet_ids
    }
  }
}



# Storage Advanced Threat Protection 
resource "azurerm_advanced_threat_protection" "atp" {
  target_resource_id = azurerm_storage_account.storageacc.id
  enabled            = var.enable_advanced_threat_protection
}

# ADLS Container Creation
resource "azurerm_storage_data_lake_gen2_filesystem" "containers" {
  count              = length(var.adlsv2_containers_list)
  name               = var.adlsv2_containers_list[count.index].name
  storage_account_id = azurerm_storage_account.storageacc.id
  properties         = var.adlsv2_containers_list[count.index].properties
}


