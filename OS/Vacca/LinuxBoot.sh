#######################################################################################################################
                                          echo "Linux Boot"
#######################################################################################################################
BIG     -   BIOS
MIKE    -   MBR
GOT     -   GRUB
KILLED  -   Kernel
IN      -   Init (SysV or SystemD)
RUSSIA  -   Runlevels

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
  dd if=/dev/vda of/mbr/copy
GRUB Grand Unified Boot Loader
  -config /boot/grub/menu.lst
  -Select different kernels, modifying Initial RAM disk initrd
  -OS Selection
  -Text Based Kernel Parameters
Kernel
  -Uncompresses into RAM
  -Establishes memory management
  -mounts root
  -kernel is PID 0
  -executes /sbin/init or systemd with PID 1
  ls -l /sbin/init  #Terra is SystemD
                    #Minas_Tirith is SysV
Init (SysV)
  -Looks at /etc/inittab
    cat /etc/inittab
  -identifies init runlevel
  -Handles by scripts in /etc/init.d/ ('S'tart and 'K'ill scripts)
  'service <service name> start | stop | restart | status | reload | …​'
  'service --status-all'
  -
Init (SystemD)
  -Loads from binarys instead of scripts
  -Uses targets instead of runlevels
  -systemctl list-dependencies <target> (graphical.target)
    systemctl status <application>.service
    systemctl list-units
  -config /etc/systemd /etc/systemd/system
  ls -lisa /lib/systemd/system/default.target

RunLevel (SystemD)
  -/lib/systemd/system 'ls -l | grep -v wants | grep run'
        -runlevel0.target - > poweroff.target
        -runlevel1.target - > rescue.target
        -runlevel2.target - > multi-user.target
        -runlevel3.target - > multi-user.target
        -runlevel4.target - > multi-user.target
        -runlevel5.target - > graphical.target
        -runlevel6.target - > reboot.target
RunLevel (SysV)
  0 - halt (Do NOT set initdefault to this)
  1 - Single user mode (switched from multi-user)
  2 - Multiuser, without networking
  3 - Full multiuser mode, with networking
  4 - unused
  5 - X11 (GUI)
  6 - reboot (Do NOT set initdefault to this)
  ‘ls -l /etc/rc<1-6>.d’ to see different services run in each runlevel
  If running something other than an init.d service, then probably malicious




############################################################################################################################
Commands for Lin Boot - 
############################################################################################################################
'
  di - disk usage
  df - disk free
  lsblk - information about block devices
  sudo xxd -l 1 -g 512 /dev/vda
  dd if=/dev/vda of/mbr/copy
  ls -l /sbin/init  #Terra is SystemD
                    #Minas_Tirith is SysV
  cat /etc/inittab
  service <service name> start | stop | restart | status | reload | …​
  service --status-all
  
  systemctl list-dependencies 
  systemsct show -p Wants graphical.target
  systemctl cat graphical.target
  systemctl status <application>.service
  systemctl list-units
  
  
  ls -lisa /lib/systemd/system/default.target  
  ls -l | grep -v wants | grep run
  ls -l /etc/rc<1-6>.d’ to see different services run in each runlevel


'





