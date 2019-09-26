resource "azurerm_key_vault" "ptfe" {
  name                            = "${local.prefix}-kv"
  resource_group_name             = "${azurerm_resource_group.ptfe.name}"
  location                        = "${var.location}"
  sku_name                        = "standard"
  tenant_id                       = "${var.key_vault_tenant_id}"
  tags                            = "${local.tags}"
  enabled_for_deployment          = true
  enabled_for_template_deployment = true
}

resource "azurerm_key_vault_access_policy" "ptfe-user" {
  key_vault_id = "${azurerm_key_vault.ptfe.id}"
  tenant_id = "${var.key_vault_tenant_id}"
  object_id = "${var.key_vault_object_id}"
  key_permissions = [
    "get",
    "list",
    "update",
    "create",
    "import",
    "delete",
  ]
  secret_permissions = [
    "get",
    "list",
    "set",
    "delete",
  ]
  certificate_permissions = [
    "get",
    "list",
    "update",
    "create",
    "import",
    "delete",
  ]
}

resource "azurerm_key_vault_access_policy" "ptfe-app" {
  key_vault_id = "${azurerm_key_vault.ptfe.id}"
  tenant_id = "${var.key_vault_tenant_id}"
  object_id = "${var.key_vault_object_id}"
  application_id = "${var.application_id}"
  key_permissions = [
    "get",
    "list",
    "update",
    "create",
    "import",
    "delete",
  ]
  secret_permissions = [
    "get",
    "list",
    "set",
    "delete",
  ]
  certificate_permissions = [
    "get",
    "list",
    "update",
    "create",
    "import",
    "delete",
  ]
}