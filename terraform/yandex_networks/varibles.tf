variable "allowed_ports" {
  type = list(string)
  default = [ "22", "3000" ]
}

variable "cidr_v4" {
  type = list(string)
  default = [ "10.10.10.0/24" ]
}