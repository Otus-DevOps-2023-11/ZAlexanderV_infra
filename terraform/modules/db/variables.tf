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

variable "folder_id" {
  description = "YC Folder ID"
  default     = null
}

variable "zone" {
  description = "YC Zone ID"
  default     = "ru-central1-a"
#  validation {
#    condition     = var.zone == null ? true : contains(["ru-central1-a", "ru-central1-b", "ru-central1-d"], var.zone)
#    error_message = "Only a valid YC region names are expected here such as ru-central1-a."
#  }
}

variable "db_disk_image" {
  description = "Disk image for reddit db"
  default     = "fd8p9bl3ifgahtb51b7p"
}

variable "instance_tags" {
  description = "additional tags to add on instance"
  type        = map(string)
  default     = {}
}
