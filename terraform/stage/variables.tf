variable "cloud_id" {
  description = "Cloud"
}
variable "folder_id" {
  description = "Folder"
}
variable "zone" {
  description = "Zone"
  default     = "ru-central1-a"
}
variable "public_key_path" {
  description = "Path to the public key used for ssh access"
}
variable "image_id" {
  description = "Disk image"
}
variable "subnet_id" {
  description = "Subnet"
  type        = string
  default     = "e9bgt4su1ihc5selb1pp"
}
variable "service_account_key_file" {
  description = "key .json"
  default     = "./key.json"
}
variable "private_key_path" {
  description = "Path to the private key"
}
variable "app_count" {
  description = "app count"
  default     = "1"
}
variable "app_disk_image" {
  description = "Disk image for reddit app"
  default     = "fd8hiodo16svum0oggif"
}
variable "db_disk_image" {
  description = "Disk image for reddit app"
  default     = "fd8p9bl3ifgahtb51b7p"
}
variable "env_database" {
  description = "Disk image for reddit app"
  default     = "reddit-db.ru-central1.internal"
}
