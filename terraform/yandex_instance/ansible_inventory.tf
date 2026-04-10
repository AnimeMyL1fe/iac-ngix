#-----------------------
# ansible-inventory
#-----------------------

locals {
  get_vm_info = {
    for k,v in yandex_compute_instance.ubuntu : k=>{
      public_ip     = v.network_interface[0].nat_ip_address
      private_ip    = v.network_interface[0].ip_address
    }
  }
}

resource "local_file" "ansible_inventory" {
  content = templatefile("${path.module}/templates/hosts.yaml.tpl", {
    vms         = local.get_vm_info
    ans_user    = var.vm_user
    ans_ssh_key = var.private_ssh_key_path
  })
  filename = "${path.module}/../../ansible/inventory/hosts.yaml"
}
