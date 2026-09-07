#!/bin/bash
#
# Copyright (C) 2016 The CyanogenMod Project
# Copyright (C) 2017-2020 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

set -e

DEVICE=mumba-motcamera
VENDOR=motorola

# Load extract_utils and do some sanity checks
MY_DIR="${BASH_SOURCE%/*}"
if [[ ! -d "${MY_DIR}" ]]; then MY_DIR="${PWD}"; fi

ANDROID_ROOT="${MY_DIR}/../../.."

HELPER="${ANDROID_ROOT}/tools/extract-utils/extract_utils.sh"
if [ ! -f "${HELPER}" ]; then
    echo "Unable to find helper script at ${HELPER}"
    exit 1
fi
source "${HELPER}"

# Default to sanitizing the vendor folder before extraction
CLEAN_VENDOR=true

KANG=
SECTION=

while [ "${#}" -gt 0 ]; do
    case "${1}" in
        -n | --no-cleanup )
                CLEAN_VENDOR=false
                ;;
        -k | --kang )
                KANG="--kang"
                ;;
        -s | --section )
                SECTION="${2}"; shift
                CLEAN_VENDOR=false
                ;;
        * )
                SRC="${1}"
                ;;
    esac
    shift
done

if [ -z "${SRC}" ]; then
    SRC="adb"
fi

# Initialize the helper
setup_vendor "${DEVICE}" "${VENDOR}" "${ANDROID_ROOT}" false "${CLEAN_VENDOR}"

extract "${MY_DIR}/proprietary-files-motcamera.txt" "${SRC}" "${KANG}" --section "${SECTION}"

# Apply apktool/smali patches to extracted blobs
BLOB_PATCHES_DIR="${MY_DIR}/blob-patches"
APKTOOL="${APKTOOL:-apktool}"

apply_blob_patch() {
    local blob="${1}"
    shift

    local apk="${OUTDIR}/proprietary/${blob}"
    if [ ! -f "${apk}" ]; then
        echo "!!! ${apk} not found, skipping blob patches"
        return 0
    fi

    local work
    work="$(mktemp -d)"

    echo "Patching ${blob}"
    "${APKTOOL}" d -f -r -o "${work}/out" "${apk}"

    local patch
    for patch in "${@}"; do
        echo "  applying $(basename "${patch}")"
        patch -p1 -d "${work}/out" < "${BLOB_PATCHES_DIR}/${patch}"
    done

    "${APKTOOL}" b -o "${work}/patched.apk" "${work}/out"
    cp "${work}/patched.apk" "${apk}"

    rm -rf "${work}"
}

# MotCamera5: drop the MotoPerf (motorola.core_services.perf) integration
apply_blob_patch "product/priv-app/MotCamera5/MotCamera5.apk" \
    "0001-MotCamera5-Remove-MotoPerf.patch"

"${MY_DIR}/setup-makefiles-motcamera.sh"
