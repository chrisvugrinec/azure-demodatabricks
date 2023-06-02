variable "tags" {}
variable "location" {}
variable "rg-name" {}
variable "logretention_days_default" {}


data "azurerm_client_config" "current" {}

data "azurerm_mssql_server" "sql-demodatabricks-custdb1" {
  name = "sql-demodatabricks-custdb1"
  resource_group_name = var.rg-name
}

data "azurerm_virtual_network" "vnet-demodatabricks-services" {
  name = "vnet-demodatabricks-services"
  resource_group_name = var.rg-name
}

data "azurerm_log_analytics_workspace" "laws-demodatabricks-logging" {
  name = "laws-demodatabricks-logging"
  resource_group_name = var.rg-name
}

data "azurerm_network_security_group" "nsg-demodatabricks-StandaardNSG"{
  name = "nsg-demodatabricks-StandaardNSG"
  resource_group_name = var.rg-name
}

data "azurerm_network_security_group" "nsg-demodatabricks-dbricks1"{
  name = "nsg-demodatabricks-dbricks1"
  resource_group_name = var.rg-name
}


