rg = {
  rg1 = {
    name     = "dhondu_rg"
    location = "centralindia"
  }
}

aks = {
  aks1 = {
    name                = "dhondu-aks"
    location            = "centralindia"
    resource_group_name = "dhondu_rg"
    dns_prefix          = "dhondu-aks"
  }
}