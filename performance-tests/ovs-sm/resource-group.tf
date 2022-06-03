resource "azurerm_resource_group" "main" {
  name     = "${local.prefix}-rg"
  location = "East US"
}