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
# remove frameworks/native
rm -rf frameworks/native
echo "=================="
echo "Removing older tree success"
echo "=================="
# Initialize repo
repo init -u https://github.com/ProjectEverest/manifest -b 14 --git-lfs
echo "=================="
echo "Repo init success"
echo "=================="
# Sync
/opt/crave/resync.sh
echo "============="
echo "Sync success"
echo "============="
# remove frameworks_native
rm -rf frameworks/native
echo "============="
echo "Removing frameworks/native success"
echo "============="
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
echo "============="
echo "cloning device specific tree success"
echo "============="
# Set up environment
. build/envsetup.sh
echo "====== Envsetup Done ======="
# clean install
make installclean
# Choose a target device
lunch lineage_mojito-userdebug
# Compile EverestOS
mka everest -j$(nproc --all)

