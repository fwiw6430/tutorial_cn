resource "oci_core_instance_configuration" "cn_config" {
  count                         = var.cn_params.node_count > 0 ? 1 : 0 
  compartment_id                = var.compartment_ocid
  display_name                  = var.cn_params.display_name

  instance_details {
    instance_type               = "compute"
    launch_details {
      availability_domain       = var.ad
      compartment_id            = var.compartment_ocid
      metadata                  = { 
        ssh_authorized_keys     = "${tls_private_key.ssh.public_key_openssh}"
        user_data               = "${base64encode(file("./user_data/cloud-init_cn.cfg"))}"
      }   
      shape                     = var.cn_params.shape
      source_details {
        source_type             = "image"
        boot_volume_size_in_gbs = var.cn_params.boot_vol_size
        image_id                = var.cn_params.image
      }   
    }   
  }
}

resource "oci_core_cluster_network" "cn" {
  count                         = var.cn_params.node_count > 0 ? 1 : 0 
  compartment_id                = var.compartment_ocid
  display_name                  = var.cn_params.display_name
  instance_pools {
    instance_configuration_id   = oci_core_instance_configuration.cn_config[0].id
    size                        = var.cn_params.node_count
    display_name                = var.cn_params.display_name
  }
  placement_configuration {
    availability_domain         = var.ad
    primary_subnet_id           = oci_core_subnet.sub["private"].id
  }
}

resource "null_resource" "cn" {
  depends_on                    = [oci_core_cluster_network.cn]
  count                         = var.cn_params.node_count > 0 ? var.cn_params.node_count : 0 
  triggers                      = {
    cn_instances                = data.oci_core_cluster_network_instances.cn_instances[0].instances[count.index]["id"]
  }
  provisioner "file" {
    content                     = tls_private_key.ssh.private_key_pem
    destination                 = "/home/${var.user_name}/.ssh/id_rsa"
    connection {
      host                      = data.oci_core_instance.cn_instances[count.index].private_ip
      type                      = "ssh"
      user                      = var.user_name
      private_key               = tls_private_key.ssh.private_key_pem
      agent                     = true
      bastion_host              = oci_core_instance.bastion.public_ip
      bastion_private_key       = tls_private_key.ssh.private_key_pem
    }
  }
  provisioner "remote-exec" {
    inline                      = [
      "chmod 600 /home/${var.user_name}/.ssh/id_rsa",
      "sudo mkdir -p /etc/oci-hpc",
    ]
    connection {
      host                      = data.oci_core_instance.cn_instances[count.index].private_ip
      type                      = "ssh"
      user                      = var.user_name
      private_key               = tls_private_key.ssh.private_key_pem
      agent                     = true
      bastion_host              = oci_core_instance.bastion.public_ip
      bastion_private_key       = tls_private_key.ssh.private_key_pem
    }
  }
  provisioner "remote-exec" {
    inline                      = [
      for instance in data.oci_core_instance.cn_instances :
        "echo ${instance.display_name} | sudo tee -a /etc/oci-hpc/hostlist.txt"
    ]
    connection {
      host                      = data.oci_core_instance.cn_instances[count.index].private_ip
      type                      = "ssh"
      user                      = var.user_name
      private_key               = tls_private_key.ssh.private_key_pem
      agent                     = true
      bastion_host              = oci_core_instance.bastion.public_ip
      bastion_private_key       = tls_private_key.ssh.private_key_pem
    }
  }
}

data "oci_core_cluster_network_instances" "cn_instances" {
  count                         = var.cn_params.node_count > 0 ? 1 : 0 
  cluster_network_id            = oci_core_cluster_network.cn[0].id
  compartment_id                = var.compartment_ocid
}

data "oci_core_instance" "cn_instances" {
  count                         = var.cn_params.node_count > 0 ? var.cn_params.node_count : 0 
  instance_id                   = data.oci_core_cluster_network_instances.cn_instances[0].instances[count.index]["id"]
}
