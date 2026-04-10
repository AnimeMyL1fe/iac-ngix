variable "allowed_ports" {
  type = list(string)
  default = [ "22", "443", "80" ]
}