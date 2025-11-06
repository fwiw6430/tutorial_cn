#compartment_ocid   = "xxxx"
#ad                 = "xxxx"
#ssh_key            = "xxxx"
exist_vcn          = false
#vcn_ocid           = "xxxx"
#public_ocid        = "xxxx"
#private_ocid       = "xxxx"
#comp_shape         = "BM.Optimized3.36"
#comp_shape         = "BM.HPC.E5.144"
#comp_shape         = "BM.GPU4.8"
#comp_shape         = "BM.GPU.A100-v2.8"
# Use HPC cluster networking image No. 12 (Oracle Linux 8.10)
#comp_image         = "ocid1.image.oc1..aaaaaaaa45plxi2fuhmbze63ynbs3xfigb2iroqpbqxh5qbauw3pbh66ddvq"
# Use HPC cluster networking image No. 13 (Oracle Linux 9.5)
#comp_image         = "ocid1.image.oc1..aaaaaaaaxtobh657yix7kj2zbbuzhwzgvlonqjhpqa23ixdlq2dwipeelxsa"
# Use GPU cluster networking image No. 14 (Oracle Linux 8.10)
#comp_image         = "ocid1.image.oc1..aaaaaaaas3btftybuhx6gm4o7t2t4bs776pn5dcpk4kgmtbzvynzjkhxoi2q"
# Use GPU cluster networking image No. 15 (Oracle Linux 9.5)
#comp_image         = "ocid1.image.oc1..aaaaaaaaevo5a2g6zd524mlu5aopkzxem6farzeilzqwcaax6nnpaflr2ipq"
comp_boot_vol_size = 100
# cloud-init config file for HPC shape
#comp_cloud_config  = "cloud-init_cnhpc.cfg"
# cloud-init config file for GPU shape
#comp_cloud_config  = "cloud-init_cngpu.cfg"
#comp_nps_x9        = "NPS1"
#comp_nps_gpu40     = "NPS4"
#comp_nps_gpu80     = "NPS4"
#comp_smt           = true
#cn_display_name    = "xxxx"
cn_node_count      = 2

user_name          = "opc"

inst_params_bast   = {
  display_name     = "bastion"
  shape            = "VM.Optimized3.Flex"
  ocpus            = 1
  memory_in_gbs    = 16
  boot_vol_size    = 100
}

cn_timeout         = "30m"
