output "resource_group_name" {
  value = "${azurerm_resource_group.ptfe.name}"
}

output "virtual_network_name" {
  value = "${azurerm_virtual_network.ptfe.name}"
}

output "subnet" {
  value = "${azurerm_subnet.ptfe.name}"
}

output "key_vault_name" {
  value = "${azurerm_key_vault.ptfe.name}"
}
