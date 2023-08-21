resource "oci_core_instance_configuration" "cn_config" {
  count                         = var.sc_cn_node_count > 0 ? 1 : 0 
  compartment_id                = var.sc_compartment_ocid
  display_name                  = var.sc_cn_display_name

  instance_details {
    instance_type               = "compute"
    launch_details {
      availability_domain       = var.sc_ad
       compartment_id           = var.sc_compartment_ocid
      metadata                  = { 
        ssh_authorized_keys     = "${tls_private_key.ssh.public_key_openssh}"
        user_data               = "${var.sc_cn_cloud_config}"
      }
      shape                     = var.sc_cn_shape
      source_details {
        source_type             = "image"
        boot_volume_size_in_gbs = var.sc_cn_boot_vol_size
        image_id                = var.sc_cn_image
      }
      platform_config {
        type                                 = var.sc_cn_shape == "BM.Optimized3.36" ? "INTEL_ICELAKE_BM" : var.sc_cn_shape == "BM.GPU4.8" ? "AMD_ROME_BM_GPU" : "AMD_MILAN_BM_GPU"
        numa_nodes_per_socket                = var.sc_cn_shape == "BM.Optimized3.36" ? var.sc_cn_nps_x9 : var.sc_cn_shape == "BM.GPU4.8" ? var.sc_cn_nps_gpu40 : var.sc_cn_nps_gpu80
        is_symmetric_multi_threading_enabled = var.sc_cn_smt
      }
    }
  }
}

resource "oci_core_cluster_network" "cn" {
  count                         = var.sc_cn_node_count > 0 ? 1 : 0 
  compartment_id                = var.sc_compartment_ocid
  display_name                  = var.sc_cn_display_name
  instance_pools {
    instance_configuration_id   = oci_core_instance_configuration.cn_config[0].id
    size                        = var.sc_cn_node_count
    display_name                = var.sc_cn_display_name
  }
  placement_configuration {
    availability_domain         = var.sc_ad
    primary_subnet_id           = oci_core_subnet.sub["private"].id
  }
}

data "oci_core_cluster_network_instances" "cn_instances" {
  count                         = var.sc_cn_node_count > 0 ? 1 : 0 
  cluster_network_id            = oci_core_cluster_network.cn[0].id
  compartment_id                = var.sc_compartment_ocid
}

data "oci_core_instance" "cn_instances" {
  count                         = var.sc_cn_node_count > 0 ? var.sc_cn_node_count : 0 
  instance_id                   = data.oci_core_cluster_network_instances.cn_instances[0].instances[count.index]["id"]
}
