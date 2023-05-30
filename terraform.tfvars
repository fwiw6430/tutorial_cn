oci  = {
  tenancy_ocid           = "ocid1.tenancy.oc1..aaaaaaaacg2kx2vh5y62jvq7bqpgmt7komml6rshkw4hlidt5y2su5gacyja"
  user_ocid              = "ocid1.user.oc1..aaaaaaaa4ymbe2oswj4xizxlrftafomsg37a2ojqjy5py2zzrsi5dzud5zxa"
  private_key_path       = "/home/opc/.oci/oci_api_key.pem"
  fingerprint            = "73:21:c8:c6:75:2c:93:64:3a:09:5f:36:3f:76:19:7a"
  region                 = "eu-frankfurt-1"
}

ad                       = "VXpT:EU-FRANKFURT-1-AD-2"
compartment_ocid         = "ocid1.compartment.oc1..aaaaaaaa6q6b7234r6urb67ztkt3osjy7dzod5svjd3mlgulacpklcnwtrda"
ssh_key                  = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCf5pkef2csDdtiZPuiz9KmwxJcXvkKrkEFEQGI44phzDxjwrtXmvxBFqly8zgUdF7ECtAu+hl53DAwjJLuZd2UpWpC4H5WSD1QluDoP6DG7cPYT3aczrrldAphyiphjl7Uz26Yb16vov9ul+/zdCokWPPBd8IVeGytrRdDf///dpyXw7jTv0I9ukis5Y6MzapxHKZKj54SH/SFZp9clcG2o4xcK+FAMlboWif3zYn8fB0Ca98ObqlhLI+ME8QAKrshDUXqYyjVmARXNz7IHhiMO5sALgjpOPM8nV3byLz+pDH1Nzl2anrz1bN/Rx0w5LFk1wbRiTo1Mae1imKWlcZUay6ts686ubYDG5HupUBW/va5cmNnnSnxy+U3VXllbQj9vWDbfi2Tw17I/4HzI2qNtaDpLzpiKHxIWuWqM35GiRWmwDZwjxM0a+RUFGvvqtLiuIUGC7UGOJ2IjTV0Ao22n3alZF5E4h6sPy/9Y87pUDFoy6pcVePDevybBAnEaNU= opc@TMIYASHI-7420"

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
  image                  = "ocid1.image.oc1..aaaaaaaazgofwgysyz5i5bupwhjmolgf44b7vlwyqxy7pmcrpbufpmvef6da"
# Grow / filesystem after provisioning by /usr/libexec/oci-growfs command if more than 50
  boot_vol_size          = 100
}
