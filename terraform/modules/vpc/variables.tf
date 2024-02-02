variable "vpc_network_name" {
  # Описание переменной
  description = "YC VPC Network name"
  default     = "app-network"
}

variable "vpc_subnet_name" {
  # Описание переменной
  description = "YC Subnet name"
  default     = "app-subnet"
}

variable "zone" {
  description = "YC Zone ID"
  default     = "ru-central1-a"
#  validation {
#    condition     = var.zone == null ? true : contains(["ru-central1-a", "ru-central1-b", "ru-central1-d"], var.zone)
#    error_message = "Only a valid YC region names are expected here such as ru-central1-a."
#  }
}

variable "yc_folder_id" {
  description = "YC Folder ID"
  default     = null
}
