variable "rg_name" {
  type = string
  description = "name of the resource group"
  default = "tim_rg"
}

variable "vnet_name" {
  type = string
  description = "name of the virtual network"
  default = "tims_vnet"
}

variable "subnet_name" {
  type = string
  description = "name of the subnet"
  default = "public_sub"
}

variable "public_ip1" {
  type = string
  description = "name of the first public Ip address for the linux virtual machine"
  default = "linux_public_ip1"
}

variable "vm_nic1" {
  type = string
  description = "name of the first NIC for the linux virtual machine"
  default = "vm1_nic"
}

variable "vm1_name" {
  type = string
  description = "name of the first linux virtual machine"
  default = "linux-vm1"
}

