locals {
  private_dns_zones = {
    privatelink-blob-core-windows-net           = "privatelink.blob.core.windows.net"
    privatelink-vaultcore-azure-net             = "privatelink.vaultcore.azure.net"
  }
}

resource "azurerm_virtual_network" "vnet-demodatabricks-services" {
  name= "vnet-demodatabricks-services"
  address_space= ["10.0.0.0/16"]
  location= var.location
  resource_group_name = var.rg-name
}


resource "azurerm_subnet" "snet-demodatabricks-customers" {
  name                 = "snet-demodatabricks-customers"
  resource_group_name  = var.rg-name
  virtual_network_name = azurerm_virtual_network.vnet-demodatabricks-services.name
  private_endpoint_network_policies_enabled = true
  address_prefixes     = ["10.0.0.0/20"]
  service_endpoints    = ["Microsoft.Storage","Microsoft.KeyVault" ]
}


resource "azurerm_subnet_network_security_group_association" "nsga-demodatabricks-customer" {
  subnet_id                 = azurerm_subnet.snet-demodatabricks-customers.id
  network_security_group_id = azurerm_network_security_group.nsg-demodatabricks-StandaardNSG.id
}

resource "azurerm_subnet" "snet-demodatabricks-beheervms" {
  name= "snet-demodatabricks-beheervms"
  resource_group_name = var.rg-name
  virtual_network_name = azurerm_virtual_network.vnet-demodatabricks-services.name
  address_prefixes     = ["10.0.17.0/25"]
  #service_endpoints    = ["Microsoft.Storage","Microsoft.KeyVault" ]
}


resource "azurerm_subnet_network_security_group_association" "nsga-demodatabricks-beheervms" {
  subnet_id                 = azurerm_subnet.snet-demodatabricks-beheervms.id
  network_security_group_id = azurerm_network_security_group.nsg-demodatabricks-StandaardNSG.id
}


resource "azurerm_subnet" "snet-demodatabricks-bastion" {
  name                 = "AzureBastionSubnet"
  resource_group_name = var.rg-name
  virtual_network_name = azurerm_virtual_network.vnet-demodatabricks-services.name
  address_prefixes     = ["10.0.16.0/26"]
}

resource "azurerm_subnet_network_security_group_association" "nsga-demodatabricks-bastion" {
  subnet_id= azurerm_subnet.snet-demodatabricks-bastion.id
  network_security_group_id = azurerm_network_security_group.nsg-demodatabricks-snetazurebastion.id
}



resource "azurerm_public_ip" "pip-demodatabricks-bastion" {
  name                = "pip-demodatabricks-bastion"
  location            = var.location
  resource_group_name = var.rg-name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_bastion_host" "abh-demodatabricks-customers" {
  name                = "abh-demodatabricks-customers"
  location            = var.location
  resource_group_name = var.rg-name

  sku                 = "Standard"

  ip_configuration {
    name                 = "configuration"
    subnet_id            = azurerm_subnet.snet-demodatabricks-bastion.id
    public_ip_address_id = azurerm_public_ip.pip-demodatabricks-bastion.id
  }
}


resource "azurerm_private_dns_zone" "pdz-demodatabricks-zones" {
  for_each            = local.private_dns_zones
  name                = each.value
  resource_group_name = var.rg-name
}

resource "azurerm_private_dns_zone_virtual_network_link" "dlnk-demodatabricks-links" {
  for_each              = local.private_dns_zones
  name                  = "${azurerm_virtual_network.vnet-demodatabricks-services.name}-link"
  resource_group_name   = var.rg-name
  private_dns_zone_name = each.value
  virtual_network_id    = azurerm_virtual_network.vnet-demodatabricks-services.id
  depends_on            = [azurerm_private_dns_zone.pdz-demodatabricks-zones]
}

