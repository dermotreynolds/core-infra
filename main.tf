terraform {
  backend "azurerm" {
    storage_account_name = "wfinfraprd010103"
    container_name       = "wfinfraprdstate010101"
    key                  = "terraform.core.state"
  }
}

#Create a resource group to put our resources into
resource "azurerm_resource_group" "wfinit_resource_group" {
  name     = "${var.organisation}-${var.department}-${var.environment}-init"
  location = "${var.azure_location}"

  tags {
    environment  = "${var.environment}"
    department   = "${var.department}"
    organisation = "${var.organisation}"
  }
}

#Create a storage account to put our state files into

resource "azurerm_storage_account" "wfinit_storage_account" {
  name                     = "${var.organisation}${var.department}${var.environment}010103"
  resource_group_name      = "${azurerm_resource_group.wfinit_resource_group.name}"
  location                 = "${azurerm_resource_group.wfinit_resource_group.location}"
  account_tier             = "Standard"
  account_replication_type = "GRS"

  tags {
    environment  = "${var.environment}"
    department   = "${var.department}"
    organisation = "${var.organisation}"
  }
}

#Create a container to put our state files into
resource "azurerm_storage_container" "wfinit_storage_container" {
  name                  = "${var.organisation}${var.department}${var.environment}state010101"
  resource_group_name   = "${azurerm_resource_group.wfinit_resource_group.name}"
  storage_account_name  = "${azurerm_storage_account.wfinit_storage_account.name}"
  container_access_type = "private"
}
