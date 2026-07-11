#
# SPDX-FileCopyrightText: The LineageOS Project
# SPDX-License-Identifier: Apache-2.0
#

PRODUCT_CHECK_PREBUILT_MAX_PAGE_SIZE := false

# Kernel
PRODUCT_ENABLE_UFFD_GC := true

# Shipping API
BOARD_SHIPPING_API_LEVEL := 202404
PRODUCT_SHIPPING_API_LEVEL := 36

# Soong namespaces
PRODUCT_SOONG_NAMESPACES += \
    $(LOCAL_PATH) \
    hardware/motorola

# Inherit from the proprietary files makefile.
$(call inherit-product, vendor/motorola/mumba/mumba-vendor.mk)
