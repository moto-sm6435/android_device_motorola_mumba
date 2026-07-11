#
# SPDX-FileCopyrightText: The LineageOS Project
# SPDX-License-Identifier: Apache-2.0
#

DEVICE_PATH := device/motorola/mumba

# Architecture
TARGET_ARCH := arm64
TARGET_ARCH_VARIANT := armv8-2a-dotprod
TARGET_CPU_ABI := arm64-v8a
TARGET_CPU_VARIANT := generic
TARGET_CPU_VARIANT_RUNTIME := kryo300

# Bootloader
TARGET_BOOTLOADER_BOARD_NAME := parrot

# DTB / DTBO
BOARD_INCLUDE_DTB_IN_BOOTIMG := true
BOARD_USES_QCOM_MERGE_DTBS_SCRIPT := true
TARGET_NEEDS_DTBOIMAGE := true
TARGET_MERGE_DTBS_WILDCARD ?= parrot*base

# Init Boot
BOARD_INIT_BOOT_HEADER_VERSION := 4
BOARD_MKBOOTIMG_INIT_ARGS += --header_version $(BOARD_INIT_BOOT_HEADER_VERSION)

# Boot
BOARD_USES_GENERIC_KERNEL_IMAGE := true
BOARD_BOOT_HEADER_VERSION := 4
BOARD_MKBOOTIMG_ARGS += --header_version $(BOARD_BOOT_HEADER_VERSION)

# Kernel
BOARD_KERNEL_CMDLINE += \
    console=ttynull \
    nosoftlockup \
    printk.devkmsg=on \
    firmware_class.path=/vendor/firmware_mnt/image \
    qcom_geni_serial.con_enabled=0 \
    sysctl.kernel.firmware_config.force_sysfs_fallback=1

BOARD_BOOTCONFIG += \
    androidboot.hardware=qcom \
    androidboot.load_modules_parallel=true \
    androidboot.memcg=1 \
    androidboot.usbcontroller=a600000.dwc3 \
    androidboot.hypervisor.protected_vm.supported=true \
    androidboot.vendor.qspa=true

BOARD_KERNEL_IMAGE_NAME := Image
BOARD_KERNEL_PAGESIZE := 4096
BOARD_KERNEL_BASE := 0x00000000
BOARD_RAMDISK_USE_LZ4 := true
TARGET_KERNEL_NO_GCC := true
INLINE_KERNEL_BUILDING := true
TARGET_FORCE_PREBUILT_KERNEL := true
TARGET_NO_KERNEL := false
BOARD_KERNEL_BINARIES := kernel
TARGET_KERNEL_VERSION := 6.6

# Prebuilt Kernel
BUILD_BROKEN_ELF_PREBUILT_PRODUCT_COPY_FILES := true
PREBUILT_PATH := $(DEVICE_PATH)-kernel
TARGET_NO_KERNEL_OVERRIDE := true
TARGET_KERNEL_SOURCE := $(PREBUILT_PATH)/kernel-headers
BOARD_PREBUILT_DTBIMAGE_DIR := $(PREBUILT_PATH)/dtbs/
BOARD_PREBUILT_DTBOIMAGE := $(PREBUILT_PATH)/dtbo.img
PRODUCT_COPY_FILES += \
    $(PREBUILT_PATH)/kernel:kernel

# Kernel modules
DLKM_MODULES_PATH := $(PREBUILT_PATH)/vendor_dlkm
RAMDISK_MODULES_PATH := $(PREBUILT_PATH)/vendor_ramdisk
SYSTEM_DLKM_MODULES_PATH := $(PREBUILT_PATH)/system_dlkm/

BOARD_SYSTEM_KERNEL_MODULES := $(wildcard $(SYSTEM_DLKM_MODULES_PATH)/*.ko)
BOARD_SYSTEM_KERNEL_MODULES_LOAD := $(patsubst %,$(SYSTEM_DLKM_MODULES_PATH)/%,$(shell cat $(SYSTEM_DLKM_MODULES_PATH)/modules.load))
BOARD_VENDOR_KERNEL_MODULES := $(wildcard $(DLKM_MODULES_PATH)/*.ko)
BOARD_VENDOR_KERNEL_MODULES_LOAD := $(patsubst %,$(DLKM_MODULES_PATH)/%,$(shell cat $(DLKM_MODULES_PATH)/modules.load))
BOARD_VENDOR_KERNEL_MODULES_BLOCKLIST_FILE := $(DLKM_MODULES_PATH)/modules.blocklist

BOARD_VENDOR_RAMDISK_KERNEL_MODULES := $(wildcard $(RAMDISK_MODULES_PATH)/*.ko)
BOARD_VENDOR_RAMDISK_KERNEL_MODULES_LOAD := $(patsubst %,$(RAMDISK_MODULES_PATH)/%,$(shell cat $(RAMDISK_MODULES_PATH)/modules.load))
BOARD_VENDOR_RAMDISK_RECOVERY_KERNEL_MODULES_LOAD  := $(patsubst %,$(RAMDISK_MODULES_PATH)/%,$(shell cat $(RAMDISK_MODULES_PATH)/modules.load.recovery))
BOARD_VENDOR_RAMDISK_KERNEL_MODULES_BLOCKLIST_FILE := $(RAMDISK_MODULES_PATH)/modules.blocklist

# Platform
BOARD_USES_QCOM_HARDWARE := true
TARGET_BOARD_PLATFORM := parrot

# Include the proprietary files BoardConfig.
include vendor/motorola/mumba/BoardConfigVendor.mk
