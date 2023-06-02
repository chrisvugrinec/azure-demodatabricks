resource "azurerm_log_analytics_workspace" "laws-demodatabricks-logging" {
  name                = "laws-demodatabricks-logging"
  location            = var.location
  resource_group_name = var.rg-name
  sku                 = "PerGB2018"
  retention_in_days   = 30
}
