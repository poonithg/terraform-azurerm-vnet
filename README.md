# Azure Virtual Network Terraform Module

### Overview
This terraform module provisions a fully functional Azure Virtual Network (VNet) with a list of private and public subnets, including the network gateway for the private subnets. <br />
This module is designed to simplify the creation of virtual networks within Azure, allowing users to configure a scalable, secure and easily maintainable networking environment for their cloud resources.

I![azurerm_vnet](https://github.com/user-attachments/assets/2acc1222-0b2b-4fa5-b48e-6a30ba05d69d)


## Requirements
- Terraform version 1.8.x
- Azure Subscription
- Required permissions to create and manage networking resources in Azure

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_nat_gateway.nat-gw](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/nat_gateway) | resource |
| [azurerm_nat_gateway_public_ip_association.nat-pip-assoc](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/nat_gateway_public_ip_association) | resource |
| [azurerm_public_ip.nat-gw-pip](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/public_ip) | resource |
| [azurerm_subnet.private](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet) | resource |
| [azurerm_subnet.public](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet) | resource |
| [azurerm_subnet_nat_gateway_association.nat-gw-assoc](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet_nat_gateway_association) | resource |
| [azurerm_virtual_network.vpc](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_location"></a> [location](#input\_location) | The location to place the resources. | `string` | n/a | yes |
| <a name="input_private-subnet"></a> [private-subnet](#input\_private-subnet) | Details about the private subnet | <pre>map(object({<br>    name             = string<br>    address_prefixes = string<br>  }))</pre> | n/a | yes |
| <a name="input_public-subnet"></a> [public-subnet](#input\_public-subnet) | Details about the private subnet | <pre>map(object({<br>    name             = string<br>    address_prefixes = string<br>  }))</pre> | n/a | yes |
| <a name="input_rg"></a> [rg](#input\_rg) | Resource Group Name | `string` | n/a | yes |
| <a name="input_vnet"></a> [vnet](#input\_vnet) | Details about the virtual network | `map(string)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_private-subnet-ids"></a> [private-subnet-ids](#output\_private-subnet-ids) | n/a |
| <a name="output_public-subnet-ids"></a> [public-subnet-ids](#output\_public-subnet-ids) | n/a |
| <a name="output_vnet-id"></a> [vnet-id](#output\_vnet-id) | n/a |

## Variables needed
```
###### TAGS VARIABLES #####
###########################
variable "client" {
  description = "The client name to be used in resource names"
  type        = string
}

variable "env" {
  description = "The environment for the resources."
  type        = string
}

##### RG VARIABLE #####
#######################
variable "rg-demo" {
  description = "Resource Group Name"
  type        = string
}

variable "location" {
  description = "The location to place the resources."
  type        = string
}


##### VNET VARIABLES #####
##########################
variable "vnet-demo" {
  description = "Details about the virtual network"
  type        = map(string)
}

##### PRIVATE SUBNET VARIABLES #####
####################################
variable "priv-subs" {
  description = "Details about the private subnet"
  type = map(object({
    name             = string
    address_prefixes = string
  }))
}

##### PUBLIC SUBNET VARIABLES #####
###################################
variable "pub-subs" {
  description = "Details about the private subnet"
  type = map(object({
    name             = string
    address_prefixes = string
  }))
}
```

## Example of tfvars file

```
##### TAGS VARIABLES #####
env    = "DEMO"
client = "GIRISH"

##### RG VARIABLE #####
rg-demo  = "xxxxxxxxxxxx"
location = "westus"

###########################################################
##### VNET VARIABLES #####
###########################################################
vnet-demo = {
  name          = "vnet-demo-01"
  address_space = "10.0.0.0/8"
}

##### PRIVATE SUBNET VARIABLES #####
priv-subs = {
  "demo-sub-priv-01" = {
    name             = "demo-sub-priv-01"
    address_prefixes = "10.1.0.0/16"
  },
  "demo-sub-priv-02" = {
    name             = "demo-sub-priv-02"
    address_prefixes = "10.2.0.0/16"
  }
}

##### PUBLIC SUBNET VARIABLES #####
pub-subs = {
  "demo-sub-pub-01" = {
    name             = "demo-sub-pub-01"
    address_prefixes = "10.10.0.0/16"
  },
  "AzureBastionSubnet" = {
    name             = "AzureBastionSubnet"
    address_prefixes = "10.20.0.0/16"
  },
  "DEMO-APP-GW-SUBNET" = {
    name             = "DEMO-APP-GW-SUBNET"
    address_prefixes = "10.100.0.0/16"
  }
}
```
