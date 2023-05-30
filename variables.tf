variable "oci" {
  description          = "OCI provider information"
  type                 = map(string)
}

variable "ad" {
  description          = "AD where OCI resources reside"
  type                 = string
}

variable "compartment_ocid" {
  description          = "Compartment OCID where resources reside"
  type                 = string
}

variable "ssh_key" {
  description          = "SSH public key to login instances"
  type                 = string
}

variable "vcn_params" {
  description          = "VCN Parameters: vcn_cidr, display_name, dns_label"
  type                 = map(string)
}

variable "igw_display_name" {
  description          = "Internet Gateway display name"
  type                 = string
}

variable "ngw_display_name" {
  description          = "NAT Gateway display name"
  type                 = string
}

variable "subnet_params" {
  description          = "Subnet Parameters"
  type = map(object({
    display_name       = string
    cidr_block         = string
    dns_label          = string
    is_subnet_private  = bool
    sl_name            = string
    rt_name            = string
  }))
}


variable "sl_params" {
  description          = "Security List Params"
  type = map(object({
    display_name       = string
    ingress_rules      = list(object({
      stateless        = string
      protocol         = string
      source           = string
      tcp_options      = list(object({
        min            = number
        max            = number
      }))
      udp_options      = list(object({
        min            = number
        max            = number
      }))
    }))
    egress_rules       = list(object({
      stateless        = string
      protocol         = string
      destination      = string
    }))
  }))
}

variable "rt_params" {
  description          = "Route Table Params"
  type                 = map(object({
    display_name       = string
    rt_rules = list(object({
      description      = string
      destination      = string
      destination_type = string
      target_is_igw    = bool
    }))
  }))
}

variable "user_name" { 
  description          = "User name to be used to access instances via SSH"
  type                 = string 
} 

variable "inst_params_bast" {
  description          = "Instance Parameters for bastion"
  type                 = map(string)
}

variable "cn_params" {
  description          = "Cluster Network Parameters"
  type                 = map(string)
}
