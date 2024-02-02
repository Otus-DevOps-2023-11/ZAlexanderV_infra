resource "yandex_vpc_network" "app-network" {
  name = var.vpc_network_name
}

resource "yandex_vpc_subnet" "app-subnet" {
  name           = var.vpc_subnet_name
  zone           = var.zone
  network_id     = yandex_vpc_network.app-network.id
  v4_cidr_blocks = ["192.168.10.0/24"]
  folder_id      = var.yc_folder_id
}
