##### RG VARIABLE #####
variable "rg" {
  description = "Resource Group Name"
  type        = string
}

variable "location" {
  description = "The location to place the resources."
  type        = string
}

variable "client" {
  description = "The client name to be used in resource names"
  type        = string
}

variable "env" {
  description = "The environment for the resources."
  type        = string
}

##### VNET VARIABLES #####
variable "vnet" {
  description = "Details about the virtual network"
  type        = map(string)
}

##### PRIVATE SUBNET VARIABLES #####
variable "private-subnet" {
  description = "Details about the private subnet"
  type = map(object({
    name             = string
    address_prefixes = string
  }))
}

##### PUBLIC SUBNET VARIABLES #####
variable "public-subnet" {
  description = "Details about the private subnet"
  type = map(object({
    name             = string
    address_prefixes = string
  }))
}
