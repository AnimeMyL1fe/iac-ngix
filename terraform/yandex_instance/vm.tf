#-----------------------
# CREATE INSTANCES
#-----------------------
resource "yandex_compute_disk" "vms_disk" {
  for_each = var.vm_configuration
  name     = each.value.vm_disk_name
  type     = each.value.vm_disk_type
  zone     = each.value.vm_zone
  image_id = data.yandex_compute_image.ubuntu_image.id
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
    disk_id = yandex_compute_disk.vms_disk[each.key].id
  }

  network_interface {
    subnet_id           = data.terraform_remote_state.network.outputs.sub_id
    nat                 = true
    security_group_ids  = [data.terraform_remote_state.network.outputs.scg_id]
  }

  metadata = {
    ssh-keys = "${var.vm_user}:${file("${var.public_ssh_key_path}")}"
  }
}
