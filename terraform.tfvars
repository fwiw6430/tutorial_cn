#compartment_ocid   = "xxxx"
#ad                 = "xxxx"
#ssh_key            = "xxxx"
exist_vcn          = false
#vcn_ocid           = "xxxx"
#public_ocid        = "xxxx"
#private_ocid       = "xxxx"
comp_shape         = "BM.Optimized3.36"
#comp_shape         = "BM.GPU4.8"
#comp_shape         = "BM.GPU.A100-v2.8"
# Use HPC image Oracle Linux 7.9 with OCA for instances connected to Cluster Network
#comp_image         = "ocid1.image.oc1..aaaaaaaano7btfbh7cvbaygka4fehemtsal7f7l2qx6oqvbwua6xnszdvaha"
# Use HPC image Oracle Linux 8.8 with OCA for instances connected to Cluster Network
#comp_image         = "ocid1.image.oc1..aaaaaaaa2irxaj3eqti6nlggadyo2avsinc6cscxrphsldiuqebcaljlqomq"
# Use HPC image Oracle Linux 8.9 with OCA for instances connected to Cluster Network
comp_image         = "ocid1.image.oc1..aaaaaaaaxiqlqer2ycd7hgto7in7raojq7v5kud6wlakmm7u7q64ai352tzq"
# Use GPU HPC image Oracle Linux 7.9 No.8
#comp_image         = "ocid1.image.oc1..aaaaaaaa42ozstmmllgevxjvcbompvj6632lwlsigaudh26os7rsmfbcoilq"
# Use GPU HPC image Oracle Linux 8.8 No.9
#comp_image         = "ocid1.image.oc1..aaaaaaaaeka3qe2v5ucxztilltohgmsyr63s3cd55uidtve4mtietoafopeq"
# Use GPU HPC image Oracle Linux 8.9 No.7
#comp_image         = "ocid1.image.oc1..aaaaaaaag36bbqszitkjcnnuauf3tiu3dg6bg2q7goj2uaxbbgnszan66fna"
comp_boot_vol_size = 100
# cloud-init config file for HPC shape
comp_cloud_config  = "cloud-init_cnhpc.cfg"
# cloud-init config file for GPU shape
#comp_cloud_config  = "cloud-init_cngpu.cfg"
comp_nps_x9        = "NPS1"
#comp_nps_gpu40     = "NPS4"
#comp_nps_gpu80     = "NPS4"
comp_smt           = true
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
