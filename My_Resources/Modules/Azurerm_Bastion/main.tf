data "azurerm_subnet" "snt" {
  for_each             = var.bastions
  name                 = "AzureBastionSubnet"
  virtual_network_name = each.value.vnetname
  resource_group_name  = each.value.resource_group_name
}

resource "azurerm_public_ip" "pip" {
  for_each            = var.bastions
  name                = each.value.pipname
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_bastion_host" "bastion" {
  for_each            = var.bastions
  name                = each.value.basname
  location            = each.value.location
  resource_group_name = each.value.resource_group_name

  ip_configuration {
    name                 = each.value.basip
    subnet_id            = data.azurerm_subnet.snt[each.key].id
    public_ip_address_id = azurerm_public_ip.pip[each.key].id
  }
}
