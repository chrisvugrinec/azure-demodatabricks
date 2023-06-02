data "azurerm_client_config" "current" {}

variable "logretention_days_default" {
  default = 90
}

data "azurerm_key_vault_secret" "kvs-demodatabricks-sqlPassword" {
  name = "kvs-demodatabricks-sqlPassword"
  key_vault_id = azurerm_key_vault.kv-demodatabricks-vault1.id
}

variable "rg-name" {
  default = "rg-cctopleiding-demodatabricks"
}


variable "location" {
  default = "westeurope"
}


variable "tags" {
  type = map(any)
  default = {
    environment     = "prod"
    department      = "ils"
    owner           = "Chris Vugrinec"
    technical_owner = "Chris Vugrinec"
  }
}
