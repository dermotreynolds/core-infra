output "storagekey" {
  value = "${azurerm_storage_account.wfinit_storage_account.primary_access_key}"
}
