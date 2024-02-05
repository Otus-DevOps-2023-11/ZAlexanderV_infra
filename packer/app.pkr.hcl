packer {
  required_plugins {
    ansible = {
      version = ">= 1.1.1"
      source  = "github.com/hashicorp/ansible"
    }
  }
}

locals {
  timestamp    = formatdate("YYMMDD-hhmm", timestamp())
  ansible_path = "${path.cwd}/../ansible"
}

variable "yc_catalog_id" {
  type = string
}

variable "svc_account_key_file" {
  type = string
}

variable "src_image_family" {
  type = string
}

variable "yc_subnet_id" {
  type = string
}

variable "inst_disk_size" {
  type    = string
  default = null
}

variable "yc_zone" {
  type    = string
  default = null
}

variable "inst_cpu_num" {
  type    = string
  default = null
}


source "yandex" "app_host" {
  folder_id                = "${var.yc_catalog_id}"
  zone                     = "${var.yc_zone}"
  image_family             = "reddit-base"
  image_name               = "reddit-app-base-${local.timestamp}"
  platform_id              = "standard-v1"
  service_account_key_file = "${var.svc_account_key_file}"
  source_image_family      = "${var.src_image_family}"
  instance_cores           = "${var.inst_cpu_num}"
  disk_size_gb             = "${var.inst_disk_size}"
  ssh_username             = "ubuntu"
  subnet_id                = "${var.yc_subnet_id}"
  use_ipv4_nat             = true
}

build {
  sources = ["source.yandex.app_host"]



  provisioner "shell" {
    execute_command = "sudo apt update"
    script          = "scripts/install_ruby.sh"
  }

  provisioner "ansible" {
    playbook_file       = "${local.ansible_path}/packer_app.yml"
    groups              = concat(["builder"], split("-", "${source.name}"))
    keep_inventory_file = true # for debugging
  }

}
