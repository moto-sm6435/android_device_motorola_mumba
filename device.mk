#
# SPDX-FileCopyrightText: The LineageOS Project
# SPDX-License-Identifier: Apache-2.0
#

PRODUCT_CHECK_PREBUILT_MAX_PAGE_SIZE := false

# Kernel
PRODUCT_ENABLE_UFFD_GC := true

# Mountpoints/Partitions
PRODUCT_USE_DYNAMIC_PARTITIONS := true
PRODUCT_BUILD_PVMFW_IMAGE := true

PRODUCT_PACKAGES += \
    vendor_bt_firmware_mountpoint \
    vendor_dsp_mountpoint \
    vendor_firmware_mnt_mountpoint \
    vendor_fsg_mountpoint \
    vendor_super_fsg_mountpoint \
    vendor_super_modem_mountpoint

# Shipping API
BOARD_SHIPPING_API_LEVEL := 202404
PRODUCT_SHIPPING_API_LEVEL := 36

# Soong namespaces
PRODUCT_SOONG_NAMESPACES += \
    $(LOCAL_PATH) \
    hardware/motorola

# Storage
$(call inherit-product, $(SRC_TARGET_DIR)/product/emulated_storage.mk)

# Inherit from the proprietary files makefile.
$(call inherit-product, vendor/motorola/mumba/mumba-vendor.mk)
