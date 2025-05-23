module "rgs" {
  source = "../../MODULES/Azurerm_Resource_Group"
  rg     = var.rg
}

# module "stg" {
#   depends_on = [module.rgs]
#   source     = "../../MODULES/Azurerm_Storage_Account"
#   storage    = var.storage
# }

# module "vnet" {
#   depends_on = [module.rgs]
#   source     = "../../MODULES/Azurerm_Virtual_Networks"
#   vnets      = var.vnets
# }

# module "vm" {
#   depends_on = [module.vnet]
#   source     = "../../MODULES/Azurerm_Virtual_machine"
#   vms        = var.vms
# }


