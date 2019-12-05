data "azurerm_client_config" "current" {}

module "bootstrap" {
  source = "./bootstrap-azure"

  #   source              = "git::ssh://git@github.com/hashicorp/private-terraform-enterprise.git//examples/bootstrap-azure?ref=master"
  location            = "${var.location}"
  prefix              = "${var.prefix}"
  key_vault_tenant_id = "${data.azurerm_client_config.current.tenant_id}"
  key_vault_object_id = "${data.azurerm_client_config.current.object_id}"

  additional_tags = {
    Application = "Terraform Enterprise Beta"
    Owner       = "${var.owner_name}"
  }
}

resource "null_resource" "create_pfx_cert" {
  provisioner "local-exec" {
    command = "create_pfx.sh ${var.domain}"
    interpreter = ["bash"]
  }
}

module "terraform_enterprise" {
  # source                       = "git::ssh://git@github.com/hashicorp/terraform-azurerm-terraform-enterprise.git"
  source = "hashicorp/terraform-enterprise/azurerm"

  # version                      = "0.0.3-beta"
  domain                        = "${var.domain}"
  domain_resource_group_name    = "${var.domain_rg_name}"
  key_vault_name                = "${module.bootstrap.key_vault_name}"
  key_vault_resource_group_name = "${module.bootstrap.resource_group_name}"
  license_file                  = "${var.license_file}"
  resource_group_name           = "${module.bootstrap.resource_group_name}"
  resource_prefix               = "${var.resource_prefix}"
  subnet                        = "${module.bootstrap.subnet}"
  storage_image                 = "${var.storage_image}"
  tls_pfx_certificate           = "security.pfx"
  tls_pfx_certificate_password  = "foobar"
  virtual_network_name          = "${module.bootstrap.virtual_network_name}"
}

output "terraform_enterprise" {
  value = {
    application_endpoint         = "${module.terraform_enterprise.application_endpoint}"
    application_health_check     = "${module.terraform_enterprise.application_health_check}"
    install_id                   = "${module.terraform_enterprise.install_id}"
    installer_dashboard_password = "${module.terraform_enterprise.installer_dashboard_password}"
    installer_dashboard_endpoint = "${module.terraform_enterprise.installer_dashboard_endpoint}"
    ssh_config                   = "${module.terraform_enterprise.ssh_config_file}"
    ssh_private_key              = "${module.terraform_enterprise.ssh_private_key}"
    primary_public_ip            = "${module.terraform_enterprise.primary_public_ip}"
  }
}