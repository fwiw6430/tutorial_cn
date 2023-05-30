provider "oci" {
  tenancy_ocid     = var.oci.tenancy_ocid
  user_ocid        = var.oci.user_ocid
  private_key_path = var.oci.private_key_path
  fingerprint      = var.oci.fingerprint
  region           = var.oci.region
}
