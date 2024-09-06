##### VPC RESOURCE #####
resource "azurerm_virtual_network" "vpc" {
  name                = lookup(var.vnet, "name")
  location            = var.location
  resource_group_name = var.rg
  address_space       = [lookup(var.vnet, "address_space")]

  tags = {
    ENVIRONMENT = var.env
    CLIENT      = var.client
    NAME        = lookup(var.vnet, "name")
    PROVIDER    = "TFprovider"
  }
}

##### PRIVATE SUBNET RESOURCE #####
resource "azurerm_subnet" "private" {
  for_each             = var.private-subnet
  name                 = each.value.name
  resource_group_name  = var.rg
  virtual_network_name = azurerm_virtual_network.vpc.name
  address_prefixes     = [each.value.address_prefixes]
}

resource "azurerm_public_ip" "nat-gw-pip" {
  for_each            = var.private-subnet
  name                = "${each.value.name}-gw-pip"
  location            = var.location
  resource_group_name = var.rg
  allocation_method   = "Static"
  sku                 = "Standard"

  tags = {
    ENVIRONMENT = var.env
    CLIENT      = var.client
    NAME        = "${each.value.name}-gw-pip"
    PROVIDER    = "TFprovider"
  }
}

##### NAT GW RESOURCE #####
resource "azurerm_nat_gateway" "nat-gw" {
  for_each                = var.private-subnet
  name                    = "${each.value.name}-gw"
  location                = var.location
  resource_group_name     = var.rg
  sku_name                = "Standard"
  idle_timeout_in_minutes = "4"

  tags = {
    ENVIRONMENT = var.env
    CLIENT      = var.client
    NAME        = "${each.value.name}-gw"
    PROVIDER    = "TFprovider"
  }
}

resource "azurerm_nat_gateway_public_ip_association" "nat-pip-assoc" {
  for_each             = var.private-subnet
  nat_gateway_id       = azurerm_nat_gateway.nat-gw[each.key].id
  public_ip_address_id = azurerm_public_ip.nat-gw-pip[each.key].id
}

##### ASSOCIATE NAT GW WITH PRIVATE SUBNET #####
resource "azurerm_subnet_nat_gateway_association" "nat-gw-assoc" {
  for_each       = var.private-subnet
  subnet_id      = azurerm_subnet.private[each.key].id
  nat_gateway_id = azurerm_nat_gateway.nat-gw[each.key].id
}

##### PUBLIC SUBNET RESOURCE #####
resource "azurerm_subnet" "public" {
  for_each             = var.public-subnet
  name                 = each.value.name
  resource_group_name  = var.rg
  virtual_network_name = azurerm_virtual_network.vpc.name
  address_prefixes     = [each.value.address_prefixes]
}
