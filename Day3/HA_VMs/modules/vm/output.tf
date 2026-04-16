output "vm_names" {
    value = azurerm_windows_virtual_machine.vm[*].name
}