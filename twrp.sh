#!/bin/bash
# Script by Mohammad Afaneh, afaneh92@xda

# Usage
case $1 in
  "") echo "Usage: twrp.sh [<device> clean|<device>]"; echo "example: twrp.sh klte clean"; exit 1;
esac;

export ALLOW_MISSING_DEPENDENCIES=true
export LC_ALL=C

# Set up the environment (variables and functions)
source build/envsetup.sh

for choice in ${LUNCH_MENU_CHOICES[@]} $(TARGET_BUILD_APPS= get_build_var COMMON_LUNCH_CHOICES)
do
  if [ "$choice" = "omni_$1-eng" ] ; then
    export target=$1;
  fi
done

# Parameter verification
if [[ -z $target ]]; then
   echo "You did not specify a necessary parameter (target)." && exit
fi

# Lunch target
lunch omni_$target-eng

# Clean the out dir;
case $2 in
  "clean") make clean;
esac;

# Fire up the building process and also log stdout and stderrout
time mka recoveryimage 2>&1 | tee twrp_$target.log

if [[ -d bootable/recovery/safestrap && -f out/target/product/$target/recovery.img ]]; then
  mka safestrap_installer
fi

# Set TWRP version to output files
twrp_version="twrp-$(grep TW_MAIN_VERSION_STR bootable/recovery/variables.h | grep -v TW_DEVICE_VERSION | awk '{print $3}' | sed 's/"//g')-$(get_build_var TW_DEVICE_VERSION)-$target-$(date '+%Y-%m-%d')"
if [[ -f $(get_build_var PRODUCT_OUT)/recovery.tar ]]; then
  cp $(get_build_var PRODUCT_OUT)/recovery.tar $(get_build_var PRODUCT_OUT)/$twrp_version.tar
fi

if [[ -f $(get_build_var PRODUCT_OUT)/recovery.img ]]; then
  cp $(get_build_var PRODUCT_OUT)/recovery.img $(get_build_var PRODUCT_OUT)/$twrp_version.img
fi

exit 0;
