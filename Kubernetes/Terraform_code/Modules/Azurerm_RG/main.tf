resource "azurerm_resource_group" "dhondhu_rg" {
    for_each = var.rg
  name     = each.value.name
  location = each.value.location
}