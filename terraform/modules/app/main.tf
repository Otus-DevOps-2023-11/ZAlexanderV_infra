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

  connection {
    type        = "ssh"
    host        = self.network_interface.0.nat_ip_address
    user        = "ubuntu"
    agent       = false
    private_key = file(var.private_key_path)
  }

  provisioner "file" {
    source      = "${path.module}/files/puma.service"
    destination = "/tmp/puma.service"
  }

  provisioner "remote-exec" {
    inline = [
      "sleep 60",
      "sudo systemctl stop reddit-app.service",
      "sudo mv /tmp/puma.service /etc/systemd/system/reddit-app.service",
      "sudo sed -i 's/ENV_DATABASE_URL.*/Environment=\"DATABASE_URL=${var.env_val_database}:27017\"/' /etc/systemd/system/reddit-app.service",
      "sudo systemctl daemon-reload",
      "sudo systemctl start reddit-app.service",
    ]
  }

}
