data "azurerm_subnet" "snt" {
  for_each             = var.vms
  name                 = each.value.sname
  virtual_network_name = each.value.vname
  resource_group_name  = each.value.resource_group_name
}

data "azurerm_key_vault" "key" {
  for_each            = var.vms
  name                = each.value.kv_name
  resource_group_name = each.value.resource_group_name
}

resource "random_password" "vmpass" {
  for_each         = var.vms
  length           = 16
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}

resource "azurerm_key_vault_secret" "password" {
  for_each     = var.vms
  name         = "${each.value.vmname}-password"
  value        = random_password.vmpass[each.key].result
  key_vault_id = data.azurerm_key_vault.key[each.key].id
}

resource "azurerm_network_interface" "nic" {
  for_each            = var.vms
  name                = each.value.nicname
  location            = each.value.location
  resource_group_name = each.value.resource_group_name

  ip_configuration {
    name                          = each.value.ipname
    subnet_id                     = data.azurerm_subnet.snt[each.key].id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_linux_virtual_machine" "myvms" {
  for_each                        = var.vms
  name                            = each.value.vmname
  resource_group_name             = each.value.resource_group_name
  location                        = each.value.location
  size                            = "Standard_F2"
  admin_username                  = "mukeshvmpass"
  admin_password                  = azurerm_key_vault_secret.password[each.key].value
  disable_password_authentication = false
  network_interface_ids           = [azurerm_network_interface.nic[each.key].id]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
}
