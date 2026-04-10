resource "yandex_vpc_subnet" "sub1" {
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.net1.id
  v4_cidr_blocks = var.cidr_v4
}

resource "yandex_vpc_network" "net1" {}
