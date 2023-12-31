


# We strongly recommend using the required_providers block to set the
# Azure Provider source and version being used
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.78.0"
    }
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {

  }
}




# Create a resource group
resource "azurerm_resource_group" "resource_group" {
  name     = var.rg_name
  location = "Eastus"
}

# Create a virtual network within the resource group

resource "azurerm_virtual_network" "vnet" {
  name                = var.vnet_name
  resource_group_name = azurerm_resource_group.resource_group.name
  location            = azurerm_resource_group.resource_group.location
  address_space       = ["10.0.0.0/16"]

  depends_on = [azurerm_resource_group.resource_group]
}

#create a subnet for the virtual machines
resource "azurerm_subnet" "pub_subnet" {
  name                 = var.subnet_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  resource_group_name  = azurerm_resource_group.resource_group.name
  address_prefixes     = ["10.0.0.0/24"]

  depends_on = [azurerm_virtual_network.vnet]
}


resource "azurerm_network_interface" "network_interface" {
  name                = var.vm_nic1
  location            = azurerm_resource_group.resource_group.location
  resource_group_name = azurerm_resource_group.resource_group.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.pub_subnet.id
    private_ip_address_allocation = "Dynamic"
    primary                       = true
    public_ip_address_id = azurerm_public_ip.linux_public_ip1.id
  }

}

#public ip for vm1
resource "azurerm_public_ip" "linux_public_ip1" {
  name                = var.public_ip1
  location            = azurerm_resource_group.resource_group.location
  resource_group_name = azurerm_resource_group.resource_group.name
  allocation_method   = "Static"
  sku                 = "Standard"

}





#Network security group for VM1
resource "azurerm_network_security_group" "network_sg" {
  name                = "allow_web"
  location            = azurerm_resource_group.resource_group.location
  resource_group_name = azurerm_resource_group.resource_group.name

  security_rule {
    name                       = "allow_https"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "Internet"
    destination_address_prefix = "*"
  }


  security_rule {
    name                       = "allow_ssh"
    priority                   = 200
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}



#associate an NSG with a VM NIC
#VM1 NSG association

resource "azurerm_network_interface_security_group_association" "vm1_nsg_nic_association" {
  network_interface_id      = azurerm_network_interface.network_interface.id
  network_security_group_id = azurerm_network_security_group.network_sg.id
}


resource "azurerm_linux_virtual_machine" "linux_vm1" {
  name                  = var.vm1_name
  resource_group_name   = azurerm_resource_group.resource_group.name 
  location              = azurerm_resource_group.resource_group.location
  size                  = "Standard_B2s"
  admin_username        = "vm"
  network_interface_ids = [azurerm_network_interface.network_interface.id]


  admin_ssh_key {
    username   = "vm"
    public_key = file("~/.ssh/id_rsa.pub")
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-focal"
    sku       = "20_04-lts"
    version   = "latest"
  }

}

