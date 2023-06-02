#NSG voor bastion netwerken
resource "azurerm_network_security_group" "nsg-demodatabricks-snetazurebastion" {
  name                = "nsg-demodatabricks-snetazurebastion"
  location            = var.location
  resource_group_name = var.rg-name

  #incoming
  security_rule {
    name                       = "AllowHttpsInbound"
    priority                   = 120
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    source_address_prefix      = "Internet"
    destination_address_prefix = "*"
    destination_port_range     = "443"
  }
  security_rule {
    name                       = "AllowGatewayManagerInbound"
    priority                   = 130
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    source_address_prefix      = "GatewayManager"
    destination_address_prefix = "*"
    destination_port_range     = "443"
  }
  security_rule {
    name                       = "AllowAzureLoadBalancerInbound"
    priority                   = 140
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    source_address_prefix      = "AzureLoadBalancer"
    destination_address_prefix = "*"
    destination_port_range     = "443"
  }
  security_rule {
    name                       = "AllowBastionHostCommunication"
    priority                   = 150
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    source_address_prefix      = "VirtualNetwork"
    destination_address_prefix = "VirtualNetwork"
    destination_port_ranges    = ["8080", "5701"]
  }
  security_rule {
    name                       = "DenyAllInbound"
    priority                   = 1000
    direction                  = "Inbound"
    access                     = "Deny"
    protocol                   = "*"
    source_port_range          = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
    destination_port_range     = "*"
  }

  #outgoing
  security_rule {
    name                       = "AllowSshRdpOutbound"
    priority                   = 100
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "VirtualNetwork"
    destination_port_ranges    = ["3389", "22"]
  }
  security_rule {
    name                       = "AllowAzureCloudOutbound"
    priority                   = 110
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "AzureCloud"
    destination_port_range     = "443"
  }
  security_rule {
    name                       = "AllowBastionCommunication"
    priority                   = 120
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    source_address_prefix      = "VirtualNetwork"
    destination_address_prefix = "VirtualNetwork"
    destination_port_ranges    = ["8080", "5701"]
  }
  security_rule {
    name                       = "AllowGetSessionInformation"
    priority                   = 130
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "Internet"
    destination_port_range     = "80"
  }
  security_rule {
    name                       = "DenyAllOutbound"
    priority                   = 1000
    direction                  = "Outbound"
    access                     = "Deny"
    protocol                   = "*"
    source_port_range          = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
    destination_port_range     = "443"
  }


}

/*
resource "azurerm_network_watcher_flow_log" "nwaf-cncz-nsgcnczsnetazurebastion" {
  name                      = "nwaf-cncz-nsgcnczsnetazurebastion"
  network_watcher_name      = data.azurerm_network_watcher.nwa-cncz-managementplatform.name
  resource_group_name       = var.rg-name
  network_security_group_id = azurerm_network_security_group.nsg-cncz-snetazurebastion.id
  storage_account_id        = data.azurerm_storage_account.sa-cncz-netflow.id
  enabled                   = true
  version                   = 2
  location                  = var.location

  retention_policy {
    enabled = true
    days    = 14
  }

  traffic_analytics {
    enabled               = true
    workspace_id          = data.azurerm_log_analytics_workspace.log-cncz-platformworkspace.workspace_id
    workspace_region      = var.location
    workspace_resource_id = data.azurerm_log_analytics_workspace.log-cncz-platformworkspace.id
    interval_in_minutes   = 10
  }
}

resource "azurerm_monitor_diagnostic_setting" "dia-cncz-nsgsnetazurebastion" {
  name                       = "dia-cncz-nsgsnetazurebastion"
  target_resource_id         = azurerm_network_security_group.nsg-cncz-snetazurebastion.id
  log_analytics_workspace_id = data.azurerm_log_analytics_workspace.log-cncz-platformworkspace.id
  lifecycle {
    ignore_changes = [
      log_analytics_destination_type
    ]
  }
  

  enabled_log {
    category = "NetworkSecurityGroupEvent"
    retention_policy {
      days    = 0
      enabled = false
    }
  }

  enabled_log {
    category = "NetworkSecurityGroupRuleCounter"
    retention_policy {
      days    = 0
      enabled = false
    }
  }
}
*/

resource "azurerm_network_security_group" "nsg-demodatabricks-StandaardNSG" {
  name                = "nsg-demodatabricks-StandaardNSG"
  location            = var.location
  resource_group_name = var.rg-name

  #incoming
  security_rule {
    name                       = "AllowSSHInbound"
    priority                   = 120
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    source_address_prefix      = "Internet"
    destination_address_prefix = "*"
    destination_port_range     = "22"
  }
  security_rule {
    name                       = "AllowRDPInbound"
    priority                   = 130
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    source_address_prefix      = "Internet"
    destination_address_prefix = "*"
    destination_port_range     = "3389"
  }
}




/*
resource "azurerm_monitor_diagnostic_setting" "dia-cncz-nsgStandaardNSG" {
  name                       = "dia-cncz-nsgStandaardNSG"
  target_resource_id         = azurerm_network_security_group.nsg-cncz-StandaardNSG.id
  log_analytics_workspace_id = data.azurerm_log_analytics_workspace.log-cncz-platformworkspace.id

  lifecycle {
    ignore_changes = [
      log_analytics_destination_type
    ]
  }

  enabled_log {
    category = "NetworkSecurityGroupEvent"
    retention_policy {
      days    = 0
      enabled = false
    }
  }

  enabled_log {
    category = "NetworkSecurityGroupRuleCounter"
    retention_policy {
      days    = 0
      enabled = false
    }
  }
}

*/

resource "azurerm_network_security_group" "nsg-demodatabricks-dbricks1" {
  name                = "nsg-demodatabricks-dbricks1"
  location            = var.location
  resource_group_name = var.rg-name


  # Inbound

  security_rule {
    name                       = "Microsoft.Databricks-workspaces_UseOnly_databricks-control-plane-to-worker-ssh"
    priority                   = 101
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "AzureDatabricks"
    destination_address_prefix = "VirtualNetwork"
    description                = ""
  }

  security_rule {
    name                       = "Microsoft.Databricks-workspaces_UseOnly_databricks-control-plane-to-worker-proxy"
    priority                   = 102
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "5557"
    source_address_prefix      = "AzureDatabricks"
    destination_address_prefix = "VirtualNetwork"
    description                = ""
  }


  # Outbound
  security_rule {
    name                       = "Microsoft.Databricks-workspaces_UseOnly_databricks-worker-to-databricks-webapp"
    priority                   = 100
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = "VirtualNetwork"
    destination_address_prefix = "AzureDatabricks"
    description                = "Required for workers communication with Databricks Webapp."
  }

 security_rule {
    name                       = "Microsoft.Databricks-workspaces_UseOnly_databricks-worker-to-sql"
    priority                   = 101
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "3306"
    source_address_prefix      = "VirtualNetwork"
    destination_address_prefix = "Sql"
    description                = "Required for workers communication with Azure SQL services."
  }

  security_rule {
    name                       = "Microsoft.Databricks-workspaces_UseOnly_databricks-worker-to-storage"
    priority                   = 102
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = "VirtualNetwork"
    destination_address_prefix = "Storage"
    description                = "Required for workers communication with Azure Storage services."
  }

  security_rule {
    name                       = "Microsoft.Databricks-workspaces_UseOnly_databricks-worker-to-eventhub"
    priority                   = 104
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "9093"
    source_address_prefix      = "VirtualNetwork"
    destination_address_prefix = "EventHub"
    description                = "Required for worker communication with Azure Eventhub services."

  }

}

/*
resource "azurerm_network_watcher_flow_log" "nwaf-cncz-nsgcnczStandaardNSG" {
  name                      = "nwaf-cncz-nsgcnczStandaardNSG"
  network_watcher_name      = data.azurerm_network_watcher.nwa-cncz-managementplatform.name
  resource_group_name       = var.rg-name
  network_security_group_id = azurerm_network_security_group.nsg-cncz-StandaardNSG.id
  storage_account_id        = data.azurerm_storage_account.sa-cncz-netflow.id
  enabled                   = true
  version                   = 2
  location                  = var.location

  retention_policy {
    enabled = true
    days    = 14
  }

  traffic_analytics {
    enabled               = true
    workspace_id          = data.azurerm_log_analytics_workspace.log-cncz-platformworkspace.workspace_id
    workspace_region      = var.location
    workspace_resource_id = data.azurerm_log_analytics_workspace.log-cncz-platformworkspace.id
    interval_in_minutes   = 10
  }
}
*/
