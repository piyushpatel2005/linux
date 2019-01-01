# LPIC Linux System Administration

## Pseudo File system

Every file and folders are nothing but a file. Everything is file including keyboard, mouse and everything. Kernel creates those file systems. Two primary pseudo file system locations are `/proc` and `/sys` files.

`/proc` contains information about the processes running on a system.

```shell
cd /proc
ls # gives process id directory
cat cpuinfo
```

`/sys` contains information about the system's hardware and kernel modules.

Linux OS includes Linux kernel which provides a way for rest of the system to operate with harware, memory, networking and itself. Kernel is monolithic and handles all memory management and hardware device interactions. Extra functionalities can be loaded and unloaded dynamically through kernel modules.

- `uname` displays information about the currently running kernel
- `lsmod` command is for listing all the currently loaded kernel modules.
- `modinfo` displays information about a specified kernel module.
- `modprobe` used to dynamically load and unload kernel modules at runtime

```shell
uname -m # shows the bit information
uname -rm # shows release version along with machine type
uname -a # shows detailed information about the kernel
lsmod # displays kernel modules
modinfo floppy # get info for floppy module
modprobe -r floppy # remove floppy kernel module
lsmod
modprobe floppy # add floppy kernel module
```

A service `udev` is unix device manager. When we attach hard drive, `udev` detects this and passes thorugh D-bus to `/dev` pseudo file system. When admin runs `lsblk` then it passes through D-bus and then can be seen by admin.

- `/dev` contains information on all of the connected hardware on a system
- `udev` is device manager for the Linux kernel, links information system hardware to `/dev`.
- D-bus sends data messages between applications, a conduit of information about what is going on in the system, `udev` utilizes D-bus to notify users and the system when new hardware is attached.
- `lspci` displays information on PCI devices attached.
- `lsusb` shows USB devices attached
- `lscpu` displays info on processors on a system
- `lsblk` displays information on all block devices on a system.

```shell
ls /dev
ls /dev/cpu # shows number of core 
ls /dev/cpu/0 # contains information about first cpu core
ls /dev/dri # contains information about video card

# once new device usb drive is attached, we can see new entry inside /dev
# Now /dev directory will have sda1 
lspci # 
lspci -k # shows detailed information about which driver is used.
lspci -v # provides more information about each hardware component capabilit
lsusb
lsusb -t # preview which USB is attached to which host controller
lscpu 
lsblk # shows which harddisks are attached to system
lsblk -f # shows which filesystem each harddisk contains
```

## Boot Process

After starting computer, BIOS check all IO devices. The Boot process begins. It is GRUB and will look for sector for data needed for starting system. Boot loader loads Linux kernel. Kernel loads RAM disk to mount file system from HD. Kernel starts initialization system. Once initialization script runs, it takes over mounting computer file sytem and RAM disk is not needed and removed. Boot logs are generated when the computer is started. It is generated from Kernel ringbuffer.

- `dmesg` used for viewing the kernel ring buffer (legacy method)
- `journalctl -k` systemd utility to view the kernel ring buffer within the systemd journal.

`init` is short for initialization. It is based off the system V init used in UNIX systems. Services are started one after the another. This can be slow if one of the process is not ready.

After kernel loads intial RAM disk. It seeks for `/sbin/init` and starts. Now init program is in control. First it reads configuration `/etc/inittab`. It looks for run level which is predefined configuration. The `/etc/inittab` file contains each group field divided by colon(:). It has id, runlevel and initdefault action. There are predefined actions. The final field shows process to execute.

`si::sysinit:/etc/rc.d/rc.sysinit`

`/etc/init.d` contains the scripts for the services on the system.
`/etc/init.d/rc.` script that orchestrates how the runlevel scripts run and what occurs when a runlevel changes.