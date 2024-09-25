#!/bin/bash

# remove local_manifest
rm -rf .repo/local_manifests/
# remove device
rm -rf device/xiaomi/mojito
rm -rf device/xiaomi/xiaomi/sm6150-common
# remove kernel
rm -rf kernel/xiaomi/mojito
# remove hardware
rm -rf hardware/xiaomi
# remove vendor
rm -rf vendor/xiaomi/mojito
rm -rf vendor/xiaomi/sm6150-common
# repository initiation
repo init -u https://github.com/ProjectEverest/manifest -b 14 --git-lfs
# repository sync
/opt/crave/resync.sh
# remove frameworks_native
rm -rf frameworks/native
# clone device tree
git clone https://github.com/anush-tree/android_device_xiaomi_mojito.git --depth 1 -b lineage-21.0 device/xiaomi/mojito
git clone https://github.com/anush-tree/android_device_xiaomi_sm6150-common.git --depth 1 -b lineage-21.0 device/xiaomi/sm6150-common
# clone kernel tree
git clone https://github.com/anush-tree/kernel_xiaomi_mojito.git --depth 1 -b inline-rom kernel/xiaomi/mojito
# clone hardware tree
git clone https://github.com/anush-tree/android_hardware_xiaomi.git --depth 1 -b mojito hardware/xiaomi
# clone vendor tree
git clone https://gitlab.com/anush-tree/android_vendor_xiaomi_mojito.git --depth 1 -b 14 vendor/xiaomi/mojito
git clone https://gitlab.com/anush-tree/android_vendor_xiaomi_sm6150-common.git --depth 1 -b 14 vendor/xiaomi/sm6150-common
# adding source
git clone https://github.com/K4LCHAKRA/frameworks_native.git --depth 1 -b 14 frameworks/native 
# setup build environment
. build/envsetup.sh
# clean install
make installclean
# lunch
lunch lineage_mojito-userdebug
# make
mka everest -j$(nproc --all)

