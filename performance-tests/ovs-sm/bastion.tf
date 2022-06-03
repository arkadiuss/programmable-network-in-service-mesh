resource "azurerm_public_ip" "k8s_cluster_bastion_ip" {
  name                = "${local.prefix}-ip"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_subnet" "bastion" {
  name                 = "AzureBastionSubnet"
  resource_group_name  = azurerm_resource_group.main.name
  virtual_network_name = azurerm_virtual_network.k8s_cluster.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_bastion_host" "k8s_cluster_bastion" {
  name                = "${local.prefix}-bastion"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name

  ip_configuration {
    name                 = "${local.prefix}-ip-configuration"
    subnet_id            = azurerm_subnet.bastion.id
    public_ip_address_id = azurerm_public_ip.k8s_cluster_bastion_ip.id
  }
}