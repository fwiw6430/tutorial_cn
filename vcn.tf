data "oci_core_services" "all_services" {
  filter {
    name                     = "name"
    values                   = ["All .* Services In Oracle Services Network"]
    regex                    = true
  }
}

resource "oci_core_virtual_network" "vcn" {
  count                      = var.exist_vcn ? 0 : 1
  compartment_id             = var.compartment_ocid
  display_name               = "vcn"
  cidr_block                 = "10.0.0.0/16"
  dns_label                  = "vcn"
}

resource "oci_core_internet_gateway" "igw" {
  count                      = var.exist_vcn ? 0 : 1
  compartment_id             = var.compartment_ocid
  vcn_id                     = oci_core_virtual_network.vcn[0].id
  display_name               = "igw"
}

resource "oci_core_nat_gateway" "ngw" {
  count                      = var.exist_vcn ? 0 : 1
  compartment_id             = var.compartment_ocid
  vcn_id                     = oci_core_virtual_network.vcn[0].id
  display_name               = "ngw"
}

resource "oci_core_service_gateway" "sgw" {
  count                      = var.exist_vcn ? 0 : 1
  compartment_id             = var.compartment_ocid
  vcn_id                     = oci_core_virtual_network.vcn[0].id
  display_name               = "sgw"
  services {
    service_id               = data.oci_core_services.all_services.services[0]["id"]
  }
}

resource "oci_core_subnet" "public" {
  count                      = var.exist_vcn ? 0 : 1
  compartment_id             = var.compartment_ocid
  vcn_id                     = oci_core_virtual_network.vcn[0].id
  display_name               = "public"
  cidr_block                 = "10.0.1.0/24"
  dns_label                  = "public"
  prohibit_public_ip_on_vnic = false
  security_list_ids          = [oci_core_security_list.public[0].id]
  route_table_id             = oci_core_route_table.public[0].id
}

resource "oci_core_subnet" "private" {
  count                      = var.exist_vcn ? 0 : 1
  compartment_id             = var.compartment_ocid
  vcn_id                     = oci_core_virtual_network.vcn[0].id
  display_name               = "private"
  cidr_block                 = "10.0.3.0/24"
  dns_label                  = "private"
  prohibit_public_ip_on_vnic = true
  security_list_ids          = [oci_core_security_list.private[0].id]
  route_table_id             = oci_core_route_table.private[0].id
}

resource "oci_core_security_list" "public" {
  count                      = var.exist_vcn ? 0 : 1
  compartment_id             = var.compartment_ocid
  vcn_id                     = oci_core_virtual_network.vcn[0].id
  display_name               = "public"
  ingress_security_rules {
    description              = "Allow SSH access from everywhere"
    stateless                = "false"
    protocol                 = "6"
    source                   = "0.0.0.0/0"
    tcp_options {
      max                    = "22"
      min                    = "22"
    }
  }
  ingress_security_rules {
    description              = "Allow all access from VCN"
    stateless                = "false"
    protocol                 = "all"
    source                   = "10.0.0.0/16"
  }
  egress_security_rules {
    description              = "Allow all access to everywhere"
    stateless                = "false"
    protocol                 = "all"
    destination              = "0.0.0.0/0"
  }
}

resource "oci_core_security_list" "private" {
  count                      = var.exist_vcn ? 0 : 1
  compartment_id             = var.compartment_ocid
  vcn_id                     = oci_core_virtual_network.vcn[0].id
  display_name               = "private"
  ingress_security_rules {
    description              = "Allow all access from VCN"
    stateless                = "false"
    protocol                 = "all"
    source                   = "10.0.0.0/16"
  }
  egress_security_rules {
    description              = "Allow all access to everywhere"
    stateless                = "false"
    protocol                 = "all"
    destination              = "0.0.0.0/0"
  }
}

resource "oci_core_route_table" "public" {
  count                      = var.exist_vcn ? 0 : 1
  compartment_id             = var.compartment_ocid
  vcn_id                     = oci_core_virtual_network.vcn[0].id
  display_name               = "public"
  route_rules {
    description              = "Default route to Internet gateway"
    destination              = "0.0.0.0/0"
    destination_type         = "CIDR_BLOCK"
    network_entity_id        = oci_core_internet_gateway.igw[0].id
  }
}

resource "oci_core_route_table" "private" {
  count                      = var.exist_vcn ? 0 : 1
  compartment_id             = var.compartment_ocid
  vcn_id                     = oci_core_virtual_network.vcn[0].id
  display_name               = "private"
  route_rules {
    description              = "Default route to NAT gateway"
    destination              = "0.0.0.0/0"
    destination_type         = "CIDR_BLOCK"
    network_entity_id        = oci_core_nat_gateway.ngw[0].id
  }
  route_rules {
    description              = "OCI all service route to Service gateway"
    destination              = data.oci_core_services.all_services.services[0]["cidr_block"]
    destination_type         = "SERVICE_CIDR_BLOCK"
    network_entity_id        = oci_core_service_gateway.sgw[0].id
  }
}

