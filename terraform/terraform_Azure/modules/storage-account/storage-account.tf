# Create a resource group
resource "azurerm_resource_group" "intuitive_resource_group" {
  name     = "intuitive-storage-resource-group"
  location = var.location
}

# Create a storage account
resource "azurerm_storage_account" "my_storage_account" {
  name                     = "mystorageaccount"
  resource_group_name      = azurerm_resource_group.intuitive_resource_group.name
  location                 = azurerm_resource_group.intuitive_resource_group.location
  account_tier             = var.account_tier
  account_replication_type = "LRS"
}