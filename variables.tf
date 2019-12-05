variable "license_file" {}
variable "domain" {}
variable "domain_rg_name" {}
variable "prefix" {}
variable "owner_name" {}
variable "location" {}
variable "resource_prefix" {}
variable "storage_image" {
  type        = "map"
  description = "A list of the data to define the os version image to build from"

  default = {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }
}