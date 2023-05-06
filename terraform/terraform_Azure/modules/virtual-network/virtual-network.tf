
# Create a resource group
resource "azurerm_resource_group" "intuitive_resource_group" {
  name     = "intuitive-resource-group"
  location = var.location
}

# Create a virtual network with a subnet
resource "azurerm_virtual_network" "intuitive_vnet" {
  name                = "Intuitive-vnet"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.intuitive_resource_group.location
  resource_group_name = azurerm_resource_group.intuitive_resource_group.name

  subnet {
    name           = "my-subnet"
    address_prefix = "10.0.1.0/24"
  }
}

# Create a network security group
resource "azurerm_network_security_group" "intuitive_nsg" {
  name                = "intuitive-nsg"
  location            = azurerm_resource_group.intuitive_resource_group.location
  resource_group_name = azurerm_resource_group.intuitive_resource_group.name

  # Allow inbound SSH traffic from the public IP address
  security_rule {
    name                       = "allow_ssh"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "0.0.0.0/0"
    destination_address_prefix = "*"
  }

  # Allow inbound HTTP traffic from any source
  security_rule {
    name                       = "allow_http"
    priority                   = 200
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

# Create a network interface for VM1
resource "azurerm_network_interface" "my_nic_1" {
  name                = "my-nic-1"
  location            = azurerm_resource_group.intuitive_resource_group.location
  resource_group_name = azurerm_resource_group.intuitive_resource_group.name

  ip_configuration {
    name                          = "testconfiguration1"
    subnet_id                     = azurerm_subnet.internal.id
    private_ip_address_allocation = "Dynamic"
  }
}


# Create a network interface for VM2
resource "azurerm_network_interface" "my_nic_2" {
  name                = "my-nic-2"
  location            = azurerm_resource_group.intuitive_resource_group.location
  resource_group_name = azurerm_resource_group.intuitive_resource_group.name

  ip_configuration {
    name                          = "testconfiguration1"
    subnet_id                     = azurerm_subnet.internal.id
    private_ip_address_allocation = "Dynamic"
  }
}



# Create two virtual machines in the subnet
resource "azurerm_linux_virtual_machine" "my_vm_1" {
  name                = "my-vm-1"
  location            = azurerm_resource_group.intuitive_resource_group.location
  resource_group_name = azurerm_resource_group.intuitive_resource_group.name
  size                = "Standard_B1s"
  admin_username      = var.admin_username
  admin_password      = var.admin_password

  network_interface_ids = [azurerm_network_interface.my_nic_1.id]

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }
  storage_os_disk {
    name              = "myosdisk1"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
}

resource "azurerm_linux_virtual_machine" "my_vm_2" {
  name                = "my-vm-2"
  location            = azurerm_resource_group.intuitive_resource_group.location
  resource_group_name = azurerm_resource_group.intuitive_resource_group.name
  size                = "Standard_B1s"
  admin_username      = var.admin_username
  admin_password      = var.admin_password

  network_interface_ids = [azurerm_network_interface.my_nic_2.id]

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }
   storage_os_disk {
    name              = "myosdisk2"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
   
}
