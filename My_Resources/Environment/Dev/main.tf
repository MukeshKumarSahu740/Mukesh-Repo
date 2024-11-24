module "resource_group" {
  source = "../../Modules/Azurerm_Resource_group"
  rgs    = var.rgs
}

module "keyvault" {
  depends_on = [module.resource_group]
  source     = "../../Modules/Azurerm_Key_Vault"
  key_vault  = var.key_vault
}

module "vnet" {
  depends_on = [module.resource_group]
  source     = "../../Modules/Azurerm_Virtual_Network"
  vnet       = var.vnet
}

module "subnet" {
  depends_on = [module.vnet]
  source     = "../../Modules/Azurerm_Subnet"
  subnet     = var.subnet
}


module "virtualmachine" {
  depends_on = [module.subnet, module.keyvault]
  source     = "../../Modules/Azurerm_Virtual_Machine"
  vms        = var.vms

}

module "bastion" {
  depends_on = [module.subnet]
  source     = "../../Modules/Azurerm_Bastion"
  bastions   = var.bastions
}
