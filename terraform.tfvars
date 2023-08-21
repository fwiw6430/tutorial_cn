#sc_compartment_ocid      = "xxxx"
#sc_ad                    = "xxxx"
#sc_ssh_key               = "xxxx"
#sc_cn_display_name       = "xxxx"
#sc_cn_shape              = "BM.Optimized3.36"
#sc_cn_shape              = "BM.GPU4.8"
#sc_cn_shape              = "BM.GPU.A100-v2.8"
#sc_cn_node_count         = 2
# Use HPC image Oracle Linux 7.9 for instances connected to Cluster Network
#sc_cn_image              = "ocid1.image.oc1..aaaaaaaa2ukz3tuyn2st5p4pnxsqx4zzg6fi25d7ns2rvywqaalgcer2tepa"
# Use HPC image Oracle Linux 8.7 for instances connected to Cluster Network
#sc_cn_image              = "ocid1.image.oc1..aaaaaaaaceagnur6krcfous5gxp2iwkv2teiqijbntbpwc4b3alxkzyqi25a"
# Use GPU HPC image Oracle Linux 7.9 for instances connected to Cluster Network
#sc_cn_image              = "ocid1.image.oc1..aaaaaaaalro3vf5xh34zvg42i3j5c4kp6rx4ndoeq6c5v5zzotl5gwjrnxra"
#sc_cn_boot_vol_size      = 100
#sc_cn_cloud_config       = "cloud-init.cfg encoded in base64"
#sc_cn_nps_x9             = "NPS2"
#sc_cn_nps_gpu40          = "NPS4"
#sc_cn_nps_gpu80          = "NPS4"
#sc_cn_smt                = false

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
  ocpus                  = 1
  memory_in_gbs          = 16
  boot_vol_size          = 50
  image                  = "^Oracle-Linux-8.*"
}
