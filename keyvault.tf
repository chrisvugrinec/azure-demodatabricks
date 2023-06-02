resource "azurerm_key_vault" "kv-demodatabricks-vault1" {
  name                        = "kv-demodatabricks-vault1"
  location                    = var.location
  resource_group_name         = var.rg-name
  enabled_for_disk_encryption = true
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  #soft_delete_retention_days  = 7
  purge_protection_enabled = true
  sku_name                 = "premium"
  enable_rbac_authorization  = true

  lifecycle {
    prevent_destroy = true
  }

/*
  network_acls {
    default_action             = "Deny"
    bypass                     = "AzureServices"
    virtual_network_subnet_ids = [ data.azurerm_subnet.snet-dataplatform-bricksPrv.id, data.azurerm_subnet.snet-dataplatform-bricksPub.id ]
  }
*/
}

resource "random_uuid" "ruid-demodatabricks-spToKV" {}

resource "azurerm_role_assignment" "ras-demodatabricks-spToKV" {
  name  = random_uuid.ruid-demodatabricks-spToKV.result
  role_definition_name = "Key Vault Administrator"
  scope                = azurerm_key_vault.kv-demodatabricks-vault1.id
  principal_id         = data.azurerm_client_config.current.object_id
}


resource "random_password" "sqlPassword" {
  length           = 16
  special          = true
  override_special = "_%@"
}


resource "azurerm_key_vault_secret" "kvs-demodatabricks-sqlPassword" {
  name         = "kvs-demodatabricks-sqlPassword"
  value        = random_password.sqlPassword.result
  key_vault_id = azurerm_key_vault.kv-demodatabricks-vault1.id
  depends_on   = [ azurerm_role_assignment.ras-demodatabricks-spToKV ]
}
