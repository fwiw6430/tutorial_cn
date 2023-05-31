oci  = {
  tenancy_ocid           = "xxxx"
  user_ocid              = "xxxx"
  private_key_path       = "/home/opc/.oci/oci_api_key.pem"
  fingerprint            = "xxxx"
  region                 = "eu-frankfurt-1"
}

ad                       = "xxxx"
compartment_ocid         = "xxxx"
ssh_key                  = "xxxx"

vcn_params               = {
  display_name           = "vcn"
  vcn_cidr               = "10.0.0.0/16"
  dns_label              = "vcn"
}

igw_display_name         = "igw"

ngw_display_name         = "ngw"

subnet_params            = {
  public                 = {
    display_name         = "public"
    cidr_block           = "10.0.1.0/24"
    dns_label            = "public"
    is_subnet_private    = false
    sl_name              = "public"
    rt_name              = "public"
  }
  private                = {
    display_name         = "private"
    cidr_block           = "10.0.2.0/24"
    dns_label            = "private"
    is_subnet_private    = true
    sl_name              = "private"
    rt_name              = "private"
  }
}

sl_params                = {
  public                 = {
    display_name         = "public"
    ingress_rules        = [
      {
        stateless        = "false"
        protocol         = "6"
        source           = "0.0.0.0/0"
        tcp_options      = [
          {
            min          = "22"
            max          = "22"
          }
        ]
        udp_options      = []
      },
      {
        stateless        = "false"
        protocol         = "all"
        source           = "10.0.0.0/16"
        tcp_options      = []
        udp_options      = []
      }
    ]
    egress_rules         = [
      {
        stateless        = "false"
        protocol         = "all"
        destination      = "0.0.0.0/0"
      }
    ]
  }
  private                = {
    display_name         = "private"
    ingress_rules        = [
      {
        stateless        = "false"
        protocol         = "all"
        source           = "10.0.0.0/16"
        tcp_options      = []
        udp_options      = []
      }
    ]
    egress_rules         = [
      {
        stateless        = "false"
        protocol         = "all"
        destination      = "0.0.0.0/0"
      }
    ]
  }
}

rt_params                = {
  public                 = {
    display_name         = "public"
    rt_rules             = [
      {
        description      = "Default route to Internet gateway"
        destination      = "0.0.0.0/0"
        destination_type = "CIDR_BLOCK"
        target_is_igw    = true
      }
    ]
  }
  private = {
    display_name         = "private"
    rt_rules             = [
      {
        description      = "Default route to NAT gateway"
        destination      = "0.0.0.0/0"
        destination_type = "CIDR_BLOCK"
        target_is_igw    = false
      }
    ]
  }
}

user_name                = "opc"

inst_params_bast         = {
  display_name           = "bastion"
  shape                  = "VM.Optimized3.Flex"
  image                  = "^Oracle-Linux-8.*"
}

cn_params                = {
  display_name           = "x9-ol8"
  shape                  = "BM.Optimized3.36"
  node_count             = 2
# Use HPC image Oracle Linux 7.9 for instances connected to Cluster Network
#  image                  = "ocid1.image.oc1..aaaaaaaayouelanobgkbsb3zanxtu6cr4bst62wco2xs5mzg3it7fp2iuvbq"
# Use HPC image Oracle Linux 8.6 for instances connected to Cluster Network
  image                  = "ocid1.image.oc1..aaaaaaaazgofwgysyz5i5bupwhjmolgf44b7vlwyqxy7pmcrpbufpmvef6da"
# Use GPU HPC image Oracle Linux 7.9 for instances connected to Cluster Network
#  image                  = "ocid1.image.oc1..aaaaaaaalro3vf5xh34zvg42i3j5c4kp6rx4ndoeq6c5v5zzotl5gwjrnxra"
# Grow / filesystem after provisioning by /usr/libexec/oci-growfs command if more than 50
  boot_vol_size          = 100
  cloud-config           = "cloud-init_cnhpc.cfg"
}
