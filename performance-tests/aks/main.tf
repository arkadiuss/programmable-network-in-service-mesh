terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.0"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "main" {
  name     = "ovs-sm-aks"
  location = "East US"
}

resource "azurerm_kubernetes_cluster" "ovssm" {
  name                = "ovs-sm-aks"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  dns_prefix          = "ovssmaks"

  default_node_pool {
    name       = "default"
    node_count = 2
    vm_size    = "Standard_B2ms"
  }

  identity {
    type = "SystemAssigned"
  }
}

output "client_certificate" {
  value     = azurerm_kubernetes_cluster.ovssm.kube_config.0.client_certificate
  sensitive = true
}

output "kube_config" {
  value = azurerm_kubernetes_cluster.ovssm.kube_config_raw
  sensitive = true
}

output "resource_group_name" {
  value     = azurerm_resource_group.main.name
}

output "kubernetes_cluster_name" {
  value = azurerm_kubernetes_cluster.ovssm.name
}