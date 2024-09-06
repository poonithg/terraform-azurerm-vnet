output "vnet-id" {
    value = azurerm_virtual_network.vpc.id
}

output "public-subnet-ids" {
  value = tomap({
    for name, subnet in azurerm_subnet.public : name => subnet.id
  })
}

output "private-subnet-ids" {
  value = tomap({
    for name, subnet in azurerm_subnet.private : name => subnet.id
  })
}