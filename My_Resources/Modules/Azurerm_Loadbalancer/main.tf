variable "location" {}
variable "resource_group_name" {}
variable "lb_name" {}

resource "azurerm_public_ip" "pip" {
  name                = "${var_lbname}-pip"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
}

resource "azurerm_lb" "lb" {
  name                = var.lb_name
  location            = var.location
  resource_group_name = var.resource_group_name

  frontend_ip_configuration {
    name                 = "PublicIPAddress"
    public_ip_address_id = azurerm_public_ip.pip.id
  }
}

resource "azurerm_lb_backend_address_pool" "netflixpool" {
  loadbalancer_id = azurerm_lb.lb.id
  name            = "${var.lb_name}-netflixpool"
}

resource "azurerm_lb_backend_address_pool" "amazonepool" {
  loadbalancer_id = azurerm_lb.lb.id
  name            = "${var.lb_name}-amazonepool"
}

data "azurerm_network_interface" "vm1_nic" {
  name                = "loadnic1"
  resource_group_name = var.resource_group_name
}

data "azurerm_network_interface" "vm2_nic" {
  name                = "loadnic2"
  resource_group_name = var.resource_group_name
}

resource "azurerm_network_interface_backend_address_pool_association" "vm1association" {
  network_interface_id    = azurerm_network_interface.vm1_nic.id
  ip_configuration_name   = "testconfiguration1"
  backend_address_pool_id = azurerm_lb_backend_address_pool.netflixpool.id
}

resource "azurerm_network_interface_backend_address_pool_association" "vm2association" {
  network_interface_id    = azurerm_network_interface.vm2_nic.id
  ip_configuration_name   = "testconfiguration1"
  backend_address_pool_id = azurerm_lb_backend_address_pool.netflixpool.id
}

resource "azurerm_lb_probe" "netflixprobe" {
  loadbalancer_id = azurerm_lb.lb.id
  name            = "netflix-probe"
  port            = 80
}

resource "azurerm_lb_rule" "lb_rule" {
  loadbalancer_id                = azurerm_lb.lb.id
  name                           = "netflixrule"
  protocol                       = "Tcp"
  frontend_port                  = 80
  backend_port                   = 80
  frontend_ip_configuration_name = "PublicIPAddress"
  backend_address_pool_ids       = [azurerm_lb_backend_address_pool.netflixpool.id]
  probe_id                       = azurerm_lb_probe.netflixprobe.id
}
