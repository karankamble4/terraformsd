provider "azurerm" {
  version = "=2.20.0"
  features {}
}

terraform {
  backend "azurerm" {
    storage_account_name = "cs210032000d56593e0"
    container_name       = "statecontainer"
    key                  = "terraform.tfstate"
   
  }
} 

locals { 
  resource_prefix = join("", ["z", lookup(var.region_tag, var.azure_region)])  
}
                                    
resource "azurerm_resource_group" "rg" {
  name     = "TOR-IT-${var.env}-RG"
  location = var.azure_region
  tags     = var.tags_base
}



module "dl_storeacc" {
  source = "./module/storage"

  rg                 =  azurerm_resource_group.rg.name
  azure_region     = var.azure_region
  storageaccountname = join("", [local.resource_prefix, "dl23",var.BU,"st1231",lookup(var.env_tag, var.env)])
  sa_tier            = lookup(var.sa_tier, var.env)
  sa_type            = lookup(var.sa_type, var.env)
  resource_tags = merge(var.tags_base, {
    "PURPOSE"     = "DATA",
    "STORAGE"     = "Y",
    "COMPUTE"     = "N",
    "PROJECT"     = "CNDL/DL-TOR-IT", #need to confirm
    "DESCRIPTION" = "" })

  soft_delete_retention = 1

  # To enable advanced threat protection set argument to `true`
  enable_advanced_threat_protection = true

  # Container lists with access_type to create
  adlsv2_containers_list = [
    { name = "raw", access_type = "private", properties = { "data" = base64encode("application") } },
    { name = "prepared", access_type = "private", properties = { "data" = base64encode("application") } },
    { name = "trusted", access_type = "private", properties = { "data" = base64encode("application") } }
  #  { name = "logs", access_type = "private", properties = { "data" = base64encode("logs") } }
  ]

  # Lifecycle management for storage account.
  # Must specify the value to each argument and default is `0`
  lifecycles = [
    #{
     # prefix_match               = ["raw/netezza"]
     # tier_to_cool_after_days    = 10
     # tier_to_archive_after_days = 50
      #delete_after_days          = 100
      #snapshot_delete_after_days = 30
    #},
    # {
    #   prefix_match               = ["blobstore251/another_path"]
    #   tier_to_cool_after_days    = 0
    #   tier_to_archive_after_days = 30
    #   delete_after_days          = 75
    #   snapshot_delete_after_days = 30
    # }
  ]
}
