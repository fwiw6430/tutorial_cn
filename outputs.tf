output "Bastion_instances_created" {
  value                = {
    "display_name"     = var.inst_params_bast.display_name
    "public_ip"        = oci_core_instance.bastion.public_ip
    "private_ip"       = oci_core_instance.bastion.private_ip
  }   
}

output "Compute_in_cn_created_none5" {
  value                = {
    for instance in data.oci_core_instance.cn_instances_none5 :
      instance.display_name => {
        "display_name" = instance.display_name
        "private_ip"   = instance.private_ip
      }
  }
}

output "Compute_in_cn_created_e5" {
  value                = {
    for instance in data.oci_core_instance.cn_instances_e5 :
      instance.display_name => {
        "display_name" = instance.display_name
        "private_ip"   = instance.private_ip
      }
  }
}
