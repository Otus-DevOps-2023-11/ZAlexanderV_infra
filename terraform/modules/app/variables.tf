variable "public_key_path" {
  # Описание переменной
  description = "Path to the public key used for ssh access"
}

variable "private_key_path" {
  # Описание переменной
  description = "Path to the private key used for ssh access"
}

variable "subnet_id" {
  description = "Subnet"
}

variable "app_disk_image" {
  description = "Disk image for reddit app"
  default     = "fd8hiodo16svum0oggif"
}

variable "env_val_database" {
  description = "Environment variable for database"
  default     = "reddit-db.ru-central1.internal"
}
