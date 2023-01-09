# Copyright (c) Microsoft Corporation. All rights reserved.
# Licensed under the MIT License.
source "azure-arm" "windowssig" {
  azure_tags = {
    sample = "basic-win-sample-vm"
  }
  os_type        = "Windows"
  communicator   = "winrm"
  winrm_username = "packer"
  winrm_timeout  = "10m"
  winrm_insecure = true
  winrm_use_ssl  = true

  # Input Image
  image_offer     = "${var.image.offer}"
  image_publisher = "${var.image.publisher}"
  image_sku       = "${var.image.sku}"
  image_version   = "${var.image.version}"

  # Build VM
  location                 = "${var.region}"
  temp_resource_group_name = "${var.temp_resource_group_name}"
  temp_compute_name        = "${var.temp_compute_name}"
  vm_size                  = "${var.vm_size}"

  # Output VHD, required by Marketplace
  use_azure_cli_auth     = true
  managed_image_name                = "${var.image_name}"
  managed_image_resource_group_name = "${var.resource_group_name}"

  shared_image_gallery_destination {
    subscription = "${var.subscription}"
    resource_group = "${var.resource_group_name}"
    gallery_name = "${var.gallery_name}"
    image_name = "${var.image_name}"
    image_version = "${var.image_version}"
    replication_regions = ["${var.region}"]
    storage_account_type = "${var.storage_account_type}"
  }
  shared_image_gallery_timeout = "3h"
}
