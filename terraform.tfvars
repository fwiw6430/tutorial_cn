#compartment_ocid      = "xxxx"
#ad                    = "xxxx"
#ssh_key               = "xxxx"
comp_shape              = "BM.Optimized3.36"
#comp_shape              = "BM.GPU4.8"
#comp_shape              = "BM.GPU.A100-v2.8"
# Use HPC image Oracle Linux 7.9 with OCA for instances connected to Cluster Network
#comp_image              = "ocid1.image.oc1..aaaaaaaano7btfbh7cvbaygka4fehemtsal7f7l2qx6oqvbwua6xnszdvaha"
# Use HPC image Oracle Linux 8.8 with OCA for instances connected to Cluster Network
#comp_image              = "ocid1.image.oc1..aaaaaaaa2irxaj3eqti6nlggadyo2avsinc6cscxrphsldiuqebcaljlqomq"
# Use HPC image Oracle Linux 8.9 with OCA for instances connected to Cluster Network
comp_image              = "ocid1.image.oc1..aaaaaaaaxiqlqer2ycd7hgto7in7raojq7v5kud6wlakmm7u7q64ai352tzq"
# Use GPU HPC image Oracle Linux 7.9 CUDA 12.4 with OCA for instances connected to Cluster Network
#comp_image              = "ocid1.image.oc1..aaaaaaaacvmchv5h7zp54vyntetzkia3hrtr5tyz7j6oiairdfjw3rutgb3q"
# Use GPU HPC image Oracle Linux 8.8 CUDA 12.2 with OCA for instances connected to Cluster Network
#comp_image              = "ocid1.image.oc1..aaaaaaaaeka3qe2v5ucxztilltohgmsyr63s3cd55uidtve4mtietoafopeq"
# Use GPU HPC image Oracle Linux 8.9 CUDA 12.4 with OCA for instances connected to Cluster Network
#comp_image              = "ocid1.image.oc1..aaaaaaaa2uaq7zbntzrc5hwoyytmpifjmrjhcfgbotyb5gbfq4cnro46cn3q"
comp_boot_vol_size      = 100
# cloud-init config file for HPC shape
comp_cloud_config       = "cloud-init_cnhpc.cfg"
# cloud-init config file for GPU shape
#comp_cloud_config       = "cloud-init_cngpu.cfg"
comp_nps_x9             = "NPS1"
#comp_nps_gpu40          = "NPS4"
#comp_nps_gpu80          = "NPS4"
comp_smt                = true
#cn_display_name       = "xxxx"
cn_node_count         = 2

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
}
