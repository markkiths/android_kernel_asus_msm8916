# AnyKernel3 Ramdisk Mod Script
# osm0sis @ xda-developers

## AnyKernel setup
# begin properties
properties() { '
kernel.string= oblivion by @markkiths based on FireKernel by theimpulson @ xda-developers
do.devicecheck=0
do.modules=0
do.cleanup=1
do.cleanuponabort=0
device.name1=Z00L
device.name2=Z00T
device.name3=
device.name4=
device.name5=
supported.versions=
supported.patchlevels=
'; } # end properties

# shell variables
block=/dev/block/bootdevice/by-name/boot;
is_slot_device=0;
ramdisk_compression=auto;


## AnyKernel methods (DO NOT CHANGE)
# import patching functions/variables - see for reference
. tools/ak3-core.sh;

## AnyKernel install
dump_boot;
write_boot;
## end install

