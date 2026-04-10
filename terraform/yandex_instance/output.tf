output "vm_info" {
  value = {for k, v in yandex_compute_instance.ubuntu : k=>{
    local_ip    = v.network_interface[0].ip_address
    public_ip   = v.network_interface[0].nat_ip_address
  }} 
}

