module "rg" {
  source = "../../Modules/Azurerm_RG"
  rg = var.rg
}

module "aks" {
    depends_on = [ module.rg ]
  source = "../../Modules/Azurerm_AKS"
  aks   = var.aks
}