resource "azurerm_mssql_server" "sql-demodatabricks-custdb1" {
  name                         = "sql-demodatabricks-custdb1"
  resource_group_name          = var.rg-name
  location                     = var.location
  version                      = "12.0"
  administrator_login          = "sqlAdmin"
  public_network_access_enabled = false
  administrator_login_password = data.azurerm_key_vault_secret.kvs-demodatabricks-sqlPassword.value
  azuread_administrator {
    login_username = "sql-admin"
    object_id      = data.azurerm_client_config.current.object_id
  }
  depends_on = [ azurerm_resource_group.rg-cctopleiding-demodatabricks ]
}
