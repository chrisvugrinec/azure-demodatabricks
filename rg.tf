resource "azurerm_resource_group" "rg-cctopleiding-demodatabricks" {
  name = var.rg-name
  location = var.location
  tags = var.tags
}
