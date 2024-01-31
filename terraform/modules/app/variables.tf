variable "public_key_path" {
  # Описание переменной
  description = "Path to the public key used for ssh access"
  default     = null
}

variable "private_key_path" {
  # Описание переменной
  description = "Path to the private key used for ssh access"
}

variable "folder_id" {
  description = "Folder to create resource"
  type        = string
  default     = null
}

variable "subnet_id" {
  description = "Subnet"
}

variable "zone" {
  description = "YC Zone ID"
  default     = "ru-central1-a"
  validation {
    condition     = var.zone == null ? true : contains(["ru-central1-a", "ru-central1-b", "ru-central1-d"], var.zone)
    error_message = "Only a valid YC region names are expected here such as ru-central1-a."
  }
}

variable "app_disk_image" {
  description = "Disk image for reddit app"
  default     = "fd8hiodo16svum0oggif"
}

variable "env_val_database" {
  description = "Environment variable for database"
  default     = "reddit-db.ru-central1.internal"
}
