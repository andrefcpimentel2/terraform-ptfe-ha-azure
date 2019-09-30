variable "tenant_id" {}
variable "object_id" {}
variable "application_id" {}
variable "certificate_path" {}
variable "cert_password" {}
variable "license_file" {}
variable "domain" {}
variable "domain_rg_name" {}
variable "prefix" {}
variable "owner_name" {}
variable "location" {}

locals {
  certificate_path = "${var.certificate_path}"
  license_path     = "${var.license_file}"
}

module "bootstrap" {
  source              = "./bootstrap-azure"
//   #source              = "git::ssh://git@github.com/hashicorp/private-terraform-enterprise.git//examples/bootstrap-azure?ref=master"
  location            = "${var.location}"
  prefix              = "${var.prefix}"
  key_vault_tenant_id = "${var.tenant_id}"
  key_vault_object_id = "${var.object_id}"
  application_id      = "${var.application_id}"

  additional_tags = {
    Application = "Terraform Enterprise"
    Owner       = "${var.owner_name}"
  }
}

module "terraform_enterprise" {
  source                       = "git::ssh://git@github.com/hashicorp/terraform-azurerm-terraform-enterprise.git"
#   source                       = "hashicorp/terraform-enterprise/azurerm"
#   version                      = "0.0.2-beta"
  domain                       = "${var.domain}"
  domain_resource_group_name   = "${var.domain_rg_name}"
  key_vault_name               = "${module.bootstrap.key_vault_name}"
  license_file                 = "${local.license_path}"
  resource_group_name          = "${module.bootstrap.resource_group_name}"
  subnet                       = "${module.bootstrap.subnet}"
  tls_pfx_certificate          = "${local.certificate_path}"
  tls_pfx_certificate_password = "${var.cert_password}"
  virtual_network_name         = "${module.bootstrap.virtual_network_name}"
}

output "terraform_enterprise" {
  value = {
    application_endpoint         = "${module.terraform_enterprise.application_endpoint}"
    application_health_check     = "${module.terraform_enterprise.application_health_check}"
    installer_dashboard_password = "${module.terraform_enterprise.installer_dashboard_password}"
    installer_dashboard_endpoint = "${module.terraform_enterprise.installer_dashboard_endpoint}"
    ssh_config                   = "${module.terraform_enterprise.ssh_config_file}"
    ssh_private_key              = "${module.terraform_enterprise.ssh_private_key}"
    primary_public_ip            = "${module.terraform_enterprise.primary_public_ip}"
  }
}