compartment_ocid   = "ocid1.compartment.oc1..aaaaaaaaunve4zxbocxmh3e75l567c5tffah3red5jfjl4whpiksqrujn33a"
ad                 = "TGjA:AP-OSAKA-1-AD-1"
ssh_key            = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCf5pkef2csDdtiZPuiz9KmwxJcXvkKrkEFEQGI44phzDxjwrtXmvxBFqly8zgUdF7ECtAu+hl53DAwjJLuZd2UpWpC4H5WSD1QluDoP6DG7cPYT3aczrrldAphyiphjl7Uz26Yb16vov9ul+/zdCokWPPBd8IVeGytrRdDf///dpyXw7jTv0I9ukis5Y6MzapxHKZKj54SH/SFZp9clcG2o4xcK+FAMlboWif3zYn8fB0Ca98ObqlhLI+ME8QAKrshDUXqYyjVmARXNz7IHhiMO5sALgjpOPM8nV3byLz+pDH1Nzl2anrz1bN/Rx0w5LFk1wbRiTo1Mae1imKWlcZUay6ts686ubYDG5HupUBW/va5cmNnnSnxy+U3VXllbQj9vWDbfi2Tw17I/4HzI2qNtaDpLzpiKHxIWuWqM35GiRWmwDZwjxM0a+RUFGvvqtLiuIUGC7UGOJ2IjTV0Ao22n3alZF5E4h6sPy/9Y87pUDFoy6pcVePDevybBAnEaNU= opc@TMIYASHI-7420"
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
# Use GPU HPC image Oracle Linux 7.9 CUDA 12.4 with OCA for instances connected to Cluster Network
#comp_image         = "ocid1.image.oc1..aaaaaaaacvmchv5h7zp54vyntetzkia3hrtr5tyz7j6oiairdfjw3rutgb3q"
# Use GPU HPC image Oracle Linux 8.8 CUDA 12.2 with OCA for instances connected to Cluster Network
#comp_image         = "ocid1.image.oc1..aaaaaaaaeka3qe2v5ucxztilltohgmsyr63s3cd55uidtve4mtietoafopeq"
# Use GPU HPC image Oracle Linux 8.9 CUDA 12.4 with OCA for instances connected to Cluster Network
#comp_image         = "ocid1.image.oc1..aaaaaaaa2uaq7zbntzrc5hwoyytmpifjmrjhcfgbotyb5gbfq4cnro46cn3q"
comp_boot_vol_size = 100
# cloud-init config file for HPC shape
comp_cloud_config  = "cloud-init_cnhpc.cfg"
# cloud-init config file for GPU shape
#comp_cloud_config  = "cloud-init_cngpu.cfg"
comp_nps_x9        = "NPS1"
#comp_nps_gpu40     = "NPS4"
#comp_nps_gpu80     = "NPS4"
comp_smt           = true
cn_display_name    = "x9-ol89"
cn_node_count      = 2

user_name          = "opc"

inst_params_bast   = {
  display_name     = "bastion"
  shape            = "VM.Optimized3.Flex"
  ocpus            = 1
  memory_in_gbs    = 16
  boot_vol_size    = 50
}
