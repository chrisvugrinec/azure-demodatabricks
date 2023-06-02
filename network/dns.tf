resource "azurerm_private_dns_zone" "pdns-demodatabricks-hostnames" {
  name= "demodatabricks.ru"
  resource_group_name = var.rg-name
}

resource "azurerm_private_dns_zone_virtual_network_link" "vlnk-demodatabricks-hostnamesToBeheer" {
  name= "vlnk-demodatabricks-hostnameToBeheer"
  resource_group_name   = var.rg-name
  private_dns_zone_name = azurerm_private_dns_zone.pdns-demodatabricks-hostnames.name
  virtual_network_id    = azurerm_virtual_network.vnet-demodatabricks-services.id
}
