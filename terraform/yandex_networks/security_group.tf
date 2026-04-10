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