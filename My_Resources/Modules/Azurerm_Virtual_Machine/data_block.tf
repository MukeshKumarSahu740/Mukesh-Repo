# data "azurerm_key_vault" "key" {
#   name                = "centralkeyvault233"
#   resource_group_name = "ramlal"
# }

# # portal me do secrets banane hain 1vm k liye(codenicsolusername & codenicsolpassword)

# data "azurerm_key_vault_secret" "username" {
#   for_each     = var.vms
#   name         = each.value.uname
#   key_vault_id = data.azurerm_key_vault.key.id
# }

# data "azurerm_key_vault_secret" "password" {
#   for_each     = var.vms
#   name         = each.value.pname
#   key_vault_id = data.azurerm_key_vault.key.id
# }
