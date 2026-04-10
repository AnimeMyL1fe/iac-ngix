data "terraform_remote_state" "network" {
    backend = "s3"
    config = {
      endpoints = { s3 = "https://storage.yandexcloud.net" }
      bucket = "ya-prac-grishin"
      region = "ru-central1"
      key    = "prac/network/terraform.tfstate"

      skip_region_validation      = true
      skip_credentials_validation = true
      skip_requesting_account_id  = true 
      skip_s3_checksum            = true 
    }
}

data "yandex_compute_image" "ubuntu_image" {
    family = "ubuntu-2204-lts"
}



