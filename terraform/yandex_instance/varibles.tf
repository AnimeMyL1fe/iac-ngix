#-----------------------------------------------
# INSTANCES VARIBLES
#-----------------------------------------------
variable "vm_configuration" {
  type = map(object({
    vm_name             = string       
    vm_disk_name        = string
    vm_disk_type        = string
    vm_disk_image_id    = string
    vm_zone             = string
    vm_profile          = string
  }))
}

variable "profiel_configuration" {
  type = map(object({
    platform_id     = string
    cores           = number
    ram             = number
    disk_size       = number 
  }))
  default = {
    "low" = {
      platform_id   = "standard-v1"
      cores         = 2
      ram           = 2
      disk_size     = 10
    }
    "meidum" = {
      platform_id   = "standard-v3"
      cores         = 2
      ram           = 4
      disk_size     = 20
    }
    "high" = {
      platform_id   = "highfreq-v3"
      cores         = 10
      ram           = 64
      disk_size     = 500
    }
  }
}


variable "vm_user" {
  type = string
  default = "ubuntu"
}

#-----------------------------------------------
# SSH
#-----------------------------------------------

variable "public_ssh_key_path" {
  type = string
}

variable "private_ssh_key_path" {
  type = string
}

