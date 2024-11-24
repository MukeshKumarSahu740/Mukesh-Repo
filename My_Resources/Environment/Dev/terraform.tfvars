rgs = {
  rg1 = {
    name     = "codenicsol"
    location = "centralindia"
  }
}

vnet = {
  vnet1 = {
    name                = "codenicsolvnet"
    location            = "centralindia"
    resource_group_name = "codenicsol"
    address_space       = ["10.0.0.0/16"]
    dns_servers         = ["10.0.0.4", "10.0.0.5"]
  }
}

subnet = {
  subnet1 = {
    name                 = "codenicsolsubnet"
    resource_group_name  = "codenicsol"
    virtual_network_name = "codenicsolvnet"
    address_prefixes     = ["10.0.1.0/24"]
  }
  subnet2 = {
    name                 = "pikachusubnet"
    resource_group_name  = "codenicsol"
    virtual_network_name = "codenicsolvnet"
    address_prefixes     = ["10.0.2.0/24"]
  }
  subnet3 = {
    name                 = "AzureBastionSubnet"
    resource_group_name  = "codenicsol"
    virtual_network_name = "codenicsolvnet"
    address_prefixes     = ["10.0.3.0/24"]
  }
}

vms = {

  vm1 = {
    nicname             = "loadnic1"
    location            = "centralindia"
    resource_group_name = "codenicsol"
    ipname              = "loadip1"
    vmname              = "loadbalancervm1"
    sname               = "codenicsolsubnet"
    vname               = "codenicsolvnet"
    kv_name             = "centralkeyvault233"
  }

  vm2 = {
    nicname             = "loadnic2"
    location            = "centralindia"
    resource_group_name = "codenicsol"
    ipname              = "loadip2"
    vmname              = "loadbalancervm2"
    sname               = "codenicsolsubnet"
    vname               = "codenicsolvnet"
    kv_name             = "centralkeyvault233"
  }
}

bastions = {
  bastion = {
    vnetname            = "codenicsolvnet"
    resource_group_name = "codenicsol"
    pipname             = "load_pip"
    location            = "centralindia"
    basname             = "loadbastion"
    basip               = "loadbasip"
  }
}

key_vault = {
  kv1 = {
    kvname              = "centralkeyvault233"
    location            = "centralindia"
    resource_group_name = "codenicsol"
    tenant_id           = "27f5b3dc-b6af-42c2-b643-b08b93250ebf"
    object_id           = "d715fa92-1f68-4e04-be7c-85693bbb6554"
  }
}

