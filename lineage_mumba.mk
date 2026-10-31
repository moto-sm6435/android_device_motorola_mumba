#
# SPDX-FileCopyrightText: The LineageOS Project
# SPDX-License-Identifier: Apache-2.0
#

# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit_only.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# Inherit from mumba device
$(call inherit-product, device/motorola/mumba/device.mk)

TARGET_DISABLE_EPPE := true
# Inherit some common Lineage stuff.
$(call inherit-product, vendor/lineage/config/common_full_phone.mk)

PRODUCT_NAME := lineage_mumba
PRODUCT_DEVICE := mumba
PRODUCT_MANUFACTURER := motorola
PRODUCT_BRAND := Motorola
PRODUCT_MODEL := Motorola G57 Power

PRODUCT_GMS_CLIENTID_BASE := android-motorola

TARGET_INCLUDE_AXFX := true
# Camera information (multiple sensors supported)
AXION_CAMERA_REAR_INFO := 50,8
AXION_CAMERA_FRONT_INFO := 16

# Maintainer name (underscores become spaces in the UI)
AXION_MAINTAINER := Viaan

# Processor name (underscores become spaces)
AXION_PROCESSOR := Snapdragon_6s_Gen_4

PRODUCT_BUILD_PROP_OVERRIDES += \
    BuildDesc="mumba_g-user 16 W1WAAS36M.48-12-ST12.1 c557f6 release-keys" \
    BuildFingerprint=motorola/mumba_g/mumba:16/W1WAAS36M.48-12-ST12.1/c557f6:user/release-keys \
    DeviceName=mumba_g \
    DeviceProduct=mumba_g \
    SystemDevice=mumba \
    SystemName=mumba
