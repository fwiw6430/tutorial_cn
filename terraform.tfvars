sc_compartment_ocid      = "ocid1.compartment.oc1..aaaaaaaaunve4zxbocxmh3e75l567c5tffah3red5jfjl4whpiksqrujn33a"
sc_ad                    = "TGjA:AP-TOKYO-1-AD-1"
sc_ssh_key               = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCf5pkef2csDdtiZPuiz9KmwxJcXvkKrkEFEQGI44phzDxjwrtXmvxBFqly8zgUdF7ECtAu+hl53DAwjJLuZd2UpWpC4H5WSD1QluDoP6DG7cPYT3aczrrldAphyiphjl7Uz26Yb16vov9ul+/zdCokWPPBd8IVeGytrRdDf///dpyXw7jTv0I9ukis5Y6MzapxHKZKj54SH/SFZp9clcG2o4xcK+FAMlboWif3zYn8fB0Ca98ObqlhLI+ME8QAKrshDUXqYyjVmARXNz7IHhiMO5sALgjpOPM8nV3byLz+pDH1Nzl2anrz1bN/Rx0w5LFk1wbRiTo1Mae1imKWlcZUay6ts686ubYDG5HupUBW/va5cmNnnSnxy+U3VXllbQj9vWDbfi2Tw17I/4HzI2qNtaDpLzpiKHxIWuWqM35GiRWmwDZwjxM0a+RUFGvvqtLiuIUGC7UGOJ2IjTV0Ao22n3alZF5E4h6sPy/9Y87pUDFoy6pcVePDevybBAnEaNU= opc@TMIYASHI-7420"
sc_cn_display_name       = "x9-ol88"
sc_cn_shape              = "BM.Optimized3.36"
#sc_cn_shape              = "BM.GPU4.8"
#sc_cn_shape              = "BM.GPU.A100-v2.8"
sc_cn_node_count         = 2
# Use HPC image Oracle Linux 7.9 with OCA for instances connected to Cluster Network
#sc_cn_image              = "ocid1.image.oc1..aaaaaaaalq4xqgkvjkrvvcvsfmfkbljgt6hfdqymyt6gpekuf622a6xktbcq"
# Use HPC image Oracle Linux 8.8 with OCA for instances connected to Cluster Network
sc_cn_image              = "ocid1.image.oc1..aaaaaaaajkzfwcucvqdui7rksrvgcaagoxutbh56pecbff7qz7gbfpruhzja"
# Use GPU HPC image Oracle Linux 7.9 with OCA for instances connected to Cluster Network
#sc_cn_image              = "ocid1.image.oc1..aaaaaaaaliisi4m7wcz6nh7mdgezjvwxdozktccuxoawlgyephuqomotb3ia"
# Use GPU HPC image Oracle Linux 8.8 with OCA for instances connected to Cluster Network
#sc_cn_image              = "ocid1.image.oc1..aaaaaaaaeka3qe2v5ucxztilltohgmsyr63s3cd55uidtve4mtietoafopeq"
sc_cn_boot_vol_size      = 100
# cloud-init config file for HPC shape
sc_cn_cloud_config       = "cloud-init_cnhpc.cfg"
# cloud-init config file for GPU shape
#sc_cn_cloud_config       = "cloud-init_cngpu.cfg"
sc_cn_nps_x9             = "NPS2"
#sc_cn_nps_gpu40          = "NPS4"
#sc_cn_nps_gpu80          = "NPS4"
sc_cn_smt                = false

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
