provider "yandex" {
  service_account_key_file = var.service_account_key_file
  cloud_id                 = var.cloud_id
  folder_id                = var.folder_id
  zone                     = var.zone
}

module "vpc" {
  source       = "../modules/vpc"
  yc_folder_id = var.folder_id
}

module "db" {
  source           = "../modules/db"
  public_key_path  = var.public_key_path
  db_disk_image    = var.db_disk_image
  subnet_id        = module.vpc.yc_subnet_id
  private_key_path = var.private_key_path
  instance_tags = {
    environment = "staging"
  }
}

module "app" {
  source           = "../modules/app"
  public_key_path  = var.public_key_path
  app_disk_image   = var.app_disk_image
  subnet_id        = module.vpc.yc_subnet_id
  private_key_path = var.private_key_path
}
