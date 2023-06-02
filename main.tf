provider "azurerm" {
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }
  #alias = "sub-rumulus-cctopleiding"
  subscription_id = "29fd3831-5eb8-45c3-b538-364dc4c2d720"
}

terraform {
  backend "azurerm" {
    resource_group_name  = "rg-rumulus-storage"
    storage_account_name = "sarumulustflzone"
    container_name       = "tfstate-landingzone"
    key                  = "cctopleiding-demos.tfstate"
  }
    required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.41.0"
    }
  }
}
