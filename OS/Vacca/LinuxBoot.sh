#######################################################################################################################
                                          echo "Linux Boot"
#######################################################################################################################
BIG     -   BIOS
MIKE    -   MBR
GOT     -   GRUB
KILLED  -   Kernel
IN      -   Init (SysV or SystemD)
RUSSIA  -   Runlevels

          "SysV"
BIOS Basic Input Output System
  -flash memory or ROM --> rootkits
  -POST power on self test
  -System Integrity
  -Device Tree
  -Executes the first sector on the MBR to load the bootloader to memory
MBR Master Boot Record
  -Located at the beginning of the bootable disk
  -contains code for GRUB
  -Could also contain LILO (linux loader)
  -located at /dev/hda /dev/sda or /dev/vda
  -4 Partitions max 2TB each
  -First 512 Bytes of disk
  di - disk usage
  df - disk free
  lsblk - information about block devices
  https://git.cybbh.space/os/public/raw/master/images/mbrPartitionTable.png
  sudo xxd -l 1 -g 512 /dev/vda
GRUB Grand Unified Boot Loader
  -config /boot/grub/menu.lst
  -Select different kernels, modifying Initial RAM disk initrd
  -OS Selection
  -Text Based Kernel Parameters
Kernel
  -Uncompresses into RAM
  -Establishes memory management
  -
  -
  -
  -
  










