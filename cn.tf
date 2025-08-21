resource "oci_core_instance_configuration" "cn_config_none5" {
  count                         = var.cn_node_count > 0 ? var.comp_shape != "BM.HPC.E5.144" ? 1 : 0 : 0
  compartment_id                = var.compartment_ocid
  display_name                  = var.cn_display_name

  instance_details {
    instance_type               = "compute"
    launch_details {
      availability_domain       = var.ad
       compartment_id           = var.compartment_ocid
      metadata                  = { 
        ssh_authorized_keys     = "${tls_private_key.ssh.public_key_openssh}"
        user_data               = "${base64encode(file("./user_data/${var.comp_cloud_config}"))}"
      }
      shape                     = var.comp_shape
      source_details {
        source_type             = "image"
        boot_volume_size_in_gbs = var.comp_boot_vol_size
        image_id                = var.comp_image
      }
      platform_config {
        type                                 = var.comp_shape == "BM.Optimized3.36" ? "INTEL_ICELAKE_BM" : var.comp_shape == "BM.GPU4.8" ? "AMD_ROME_BM_GPU" : "AMD_MILAN_BM_GPU"
        numa_nodes_per_socket                = var.comp_shape == "BM.Optimized3.36" ? var.comp_nps_x9 : var.comp_shape == "BM.GPU4.8" ? var.comp_nps_gpu40 : var.comp_nps_gpu80
        is_symmetric_multi_threading_enabled = var.comp_smt
      }
      agent_config {
        plugins_config {
          desired_state         = "ENABLED"
          name                  = "Compute HPC RDMA Authentication"
        }
        plugins_config {
          desired_state         = "ENABLED"
          name                  = "Compute HPC RDMA Auto-Configuration"
        }
      }
    }
  }
}

resource "oci_core_instance_configuration" "cn_config_e5" {
  count                         = var.cn_node_count > 0 ? var.comp_shape == "BM.HPC.E5.144" ? 1 : 0 : 0
  compartment_id                = var.compartment_ocid
  display_name                  = var.cn_display_name

  instance_details {
    instance_type               = "compute"
    launch_details {
      availability_domain       = var.ad
       compartment_id           = var.compartment_ocid
      metadata                  = { 
        ssh_authorized_keys     = "${tls_private_key.ssh.public_key_openssh}"
        user_data               = "${base64encode(file("./user_data/${var.comp_cloud_config}"))}"
      }
      shape                     = var.comp_shape
      source_details {
        source_type             = "image"
        boot_volume_size_in_gbs = var.comp_boot_vol_size
        image_id                = var.comp_image
      }
      agent_config {
        plugins_config {
          desired_state         = "ENABLED"
          name                  = "Compute HPC RDMA Authentication"
        }
        plugins_config {
          desired_state         = "ENABLED"
          name                  = "Compute HPC RDMA Auto-Configuration"
        }
      }
    }
  }
}

resource "oci_core_cluster_network" "cn_none5" {
  count                         = var.cn_node_count > 0 ? var.comp_shape != "BM.HPC.E5.144" ? 1 : 0 : 0
  compartment_id                = var.compartment_ocid
  display_name                  = var.cn_display_name
  instance_pools {
    instance_configuration_id   = oci_core_instance_configuration.cn_config_none5[0].id
    size                        = var.cn_node_count
    display_name                = var.cn_display_name
  }
  placement_configuration {
    availability_domain         = var.ad
    primary_subnet_id           = var.exist_vcn ? var.private_ocid : oci_core_subnet.private[0].id
  }
  timeouts {
    create                      = var.cn_timeout
  }
}

resource "oci_core_cluster_network" "cn_e5" {
  count                         = var.cn_node_count > 0 ? var.comp_shape == "BM.HPC.E5.144" ? 1 : 0 : 0
  compartment_id                = var.compartment_ocid
  display_name                  = var.cn_display_name
  instance_pools {
    instance_configuration_id   = oci_core_instance_configuration.cn_config_e5[0].id
    size                        = var.cn_node_count
    display_name                = var.cn_display_name
  }
  placement_configuration {
    availability_domain         = var.ad
    primary_subnet_id           = var.exist_vcn ? var.private_ocid : oci_core_subnet.private[0].id
  }
  timeouts {
    create                      = var.cn_timeout
  }
}

data "oci_core_cluster_network_instances" "cn_instances_none5" {
  count                         = var.cn_node_count > 0 ? var.comp_shape != "BM.HPC.E5.144" ? 1 : 0 : 0
  cluster_network_id            = oci_core_cluster_network.cn_none5[0].id
  compartment_id                = var.compartment_ocid
}

data "oci_core_cluster_network_instances" "cn_instances_e5" {
  count                         = var.cn_node_count > 0 ? var.comp_shape == "BM.HPC.E5.144" ? 1 : 0 : 0
  cluster_network_id            = oci_core_cluster_network.cn_e5[0].id
  compartment_id                = var.compartment_ocid
}

data "oci_core_instance" "cn_instances_none5" {
  count                         = var.cn_node_count > 0 ? var.comp_shape != "BM.HPC.E5.144" ? var.cn_node_count : 0 : 0
  instance_id                   = data.oci_core_cluster_network_instances.cn_instances_none5[0].instances[count.index]["id"]
}

data "oci_core_instance" "cn_instances_e5" {
  count                         = var.cn_node_count > 0 ? var.comp_shape == "BM.HPC.E5.144" ? var.cn_node_count : 0 : 0
  instance_id                   = data.oci_core_cluster_network_instances.cn_instances_e5[0].instances[count.index]["id"]
}
