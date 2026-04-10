resource "yandex_compute_disk" "my_disk" {
  for_each = var.vm_configuration
  name     = each.value.vm_disk_name
  type     = each.value.vm_disk_type
  zone     = each.value.vm_zone
  image_id = each.value.vm_disk_image_id
  size     = var.profiel_configuration[each.value.vm_profile].disk_size

}

resource "yandex_compute_instance" "ubuntu" {
  for_each    = var.vm_configuration
  name        = each.value.vm_name 
  platform_id = var.profiel_configuration[each.value.vm_profile].platform_id
  zone        = each.value.vm_zone

  resources {
    cores  = var.profiel_configuration[each.value.vm_profile].cores
    memory = var.profiel_configuration[each.value.vm_profile].ram
  }

  boot_disk {
    disk_id = yandex_compute_disk.my_disk[each.key].id
  }

  network_interface {
    subnet_id   = yandex_vpc_subnet.sub1.id
    nat         = true
    security_group_ids = [yandex_vpc_security_group.sg1.id]
  }

  metadata = {
    ssh-keys = "${var.vm_user}:${file("${var.public_ssh_key_path}")}"
  }
}

resource "yandex_vpc_network" "net1" {}

resource "yandex_vpc_subnet" "sub1" {
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.net1.id
  v4_cidr_blocks = ["10.10.10.0/24"]
}


#----------------------------------------------------------------

//
// Create a new VPC Security Group.
//
resource "yandex_vpc_security_group" "sg1" {
  name        = "web-secret-groups"
  description = "Default setup"
  network_id  = yandex_vpc_network.net1.id

  labels = {
    my-label = "my-label-value"
  }

  dynamic "ingress" {
    for_each = var.allowed_ports
    content {
        protocol       = "TCP"
        description    = "Allowed ports"
        v4_cidr_blocks = ["0.0.0.0/0"]
        port           = ingress.value
    }
  }
  

  egress {
    description    = "Permit ANY"
    protocol       = "ANY"
    v4_cidr_blocks = ["0.0.0.0/0"]
  }
}

#----------------------------------------------------------------------------
locals {
  get_vm_info = {
    for k,v in yandex_compute_instance.ubuntu : k=>{
      ip = v.network_interface[0].nat_ip_address
    }
  }
}

resource "local_file" "ansible_inventory" {
  content = templatefile("${path.module}/templates/hosts.yaml.tpl", {
    vms = local.get_vm_info
    ans_user    = var.vm_user
    ans_ssh_key = var.private_ssh_key_path
  })
  filename = "${path.module}/../ansible/inventory/hosts.yaml"
}
