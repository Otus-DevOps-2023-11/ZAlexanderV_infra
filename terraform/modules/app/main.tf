#terraform {
#  required_providers {
#    yandex = {
#      source = "yandex-cloud/yandex"
#    }
#  }
#}

resource "yandex_compute_instance" "app" {
  name = "reddit-app"

  labels = {
    tags = "reddit-app"
  }
  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = var.app_disk_image
    }
  }

  network_interface {
    subnet_id = var.subnet_id
    nat       = true
  }

  metadata = {
    ssh-keys = "ubuntu:${file(var.public_key_path)}"
  }

  provisioner "file" {
    source      = "../files/puma.service"
    destination = "/tmp/puma.service"
  }

  provisioner "remote-exec" {
    script = "../files/deploy.sh"
  }
  provisioner "remote-exec" {
    inline = [
      "sleep 60",
      "export DATABASE_URL=${var.env_val_database}",
      "sudo sed -i 's|ExecStart=/bin/bash -lc.*|ExecStart=/bin/bash -lc \"DATABASE_URL=${var.env_val_database}:27017 puma\"|' /etc/systemd/system/puma.service",
      "sudo systemctl daemon-reload",
      "sudo systemctl restart puma",
    ]
  }

}
