variable "azure_region" {
  default = "Canada Central"
}

variable "tags_base" {
  default = {
    "BU"              = "IT"
    "NETWORK CODE"    = "CD256014"
    "ENVIRONMENT"     = "DEV"
    "PROJECT"         = "CNDL"
    "created-by"      = "Gaby Tessier"
    "Owner"           = "Charles Abondo"
    "Financial Owner" = "Pascal David"
  }
}

variable "env" {
  default     = "DEV"
  description = "Environment onto which the resource would be deployed"
}

variable "rg" {
  default = ""
}


variable "BU"{
   description = "Bussiness Unit name according to IT product"
   default="it"
   type=string
}



variable "env_tag" {
  default = {
    "DEV"="d",
    "STG"="s",
    "PROD"="p"
  }
}

variable "region_tag" {
  default = {
    "Canada Central" = "cc1"
  }
}

variable "sa_type" {
  default = {
    "npd" = "LRS",
    "DEV"="LRS",
    "PROD"="LRS",
    "STG"="LRS"
  }
}

variable "sa_tier" {
  default = {
    "npd" = "Standard",
     "DEV"="Standard",
    "PROD"="Standard",
    "STG"="Standard"
  }
}


