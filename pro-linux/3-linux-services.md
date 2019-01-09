# Startups and Services

The boot process involves three separate but connected processe: the BIOS (Basic Input/Output system) or UEFI Unified Extensible Firmware Interface, the boot loader and the loading of OS.
The BIOS or UEFI initiates and checks the hardware. The boot loader lets you select an OS to load. Finally, your operating system is loaded and initiated. Modern hardware will support UEFI.

### Powering On

When turning on, we hear a few beeps and see some blinking on front panel and keyboard. This process is controlled by a small chip on motherboard called BIOS.

**The BIOS** performs system checks and power-on self-test (POST) operations on the availability of different bits of hardware attached to system, like memory, hard drives, keyboard and video card. The BIOS will also poll other hardware such as hard drive controllers and initiate their onboard chips. Depending on your hardware, you may see BIoS screen followed by information about devices the controller has found. You may be given option to configure controllers and other hardware by pressing certain key sequences. This allows to manipulate the configuration of host. Incorrectly changing a RAID configuration could destroy data, so use these menus with caution.

The BIOS also allows to change the boot source for host. Every motherboard manufacturer has a different way of getting to the boot menu, for example by pressing Esc, Del ro function key such as F1, F2 or F10.

Most recent motherboards support UEFI. It is similar to BIOS but little faster than BIOS. BIOS runs on a 16-bit processor. UEFI can run on modern processors. BIOS was limited in RAM, UEFI can run in as much RAM as required. BIOS reads from a small section of a hard drive (the master boot record, MBR) to load the operating system. UEFI instead reads from a special FAT32 partition created at installation time and is not limited to 512 bytes. UEFI also requires that the partition table on the disk is GPT (GUID Partition Table) and we can boot off disks over 2TB in size. 

One of the ways malware can be loaded on a system is via boot loader. UEFI offers "secure boot" that is designed to protect against this by verifying signed boot loaders and hardware via public/private keys befoer loading them. Most hardwares support this, but some hardwares might have problem with secure boot. In that case, disable secure boot via UEFI configuration screen.

Currently, you can use UEFI or BIOS in most motherboards as "legacy". It is however mandatory  under the circumstances like you are running dual boot with a system already running UEFI and you want to access disks larger than 2TB.

When we partition (slice up) a disk, we are creating a table called partition table. The partition table is normally found at the beginning of the disk and tells the computer how the disk has been laid out, how much of the disk has been allocated to `/boot` partition, how much is expected to be logical volume management (LVM) and so on. A partition table holds information about the block addresses (in chunks of 512 bytes or 4KB of disk). The MBR can only hold 2TBs worth of addresses while GPT can hold 8-9ZB.

A disk will have either a MBR at the start or GPT. If it has MBR, the partition table is written after the first 446 bytes of disk. The size of the partition table is 64 bytes and is followed by the MBR boot signature. The remaining space up until the first partition is often called MBR gap and varies in size as most partitioners align the start of partitions to the first 1MB.

Once the host has loaded all attached hardware and has set low-level system settings, it is ready to boot up OS. BIOS or UEFI doesn't know about OS, but it does know how to run the code supplied by distros. This code is called the Boot Loader and it needs to be in the right place on disk you are booting from. A host running BIOS uses the boot source setting to specify where to look for the next stage of the boot process. The BIOS uses special section called master boot record.

When we install OS, our installation installed a boot loader called GRUB2 (GRand Unified Bootloader 2) and its job is to launch itself, then find, load and hand off to the OS. The first stage of the boot loader will be stored in the 446 bytes at the start of the disk. For linux, it's called `boot.img`. When BIOS executes it, it finds and runs a file called `core.img`. This file is normally installed into MBR gap. The job of this is to access `/boot/grub` and load the modules it finds there. The `core.img` will load the menu and has the ability to load the target OS.

**Boot loader with UEFI** can read GPT partition table and can find and execute boot loader code in the `/EFI/` directory in EFI system partition. UEFI has its own partition that the boot loader and modules can be installed into. After installation, we will have three partitions on drive `/dev/sda`. First noe is EFI system partition (FAT32) and contains boot and esp flags, meaning it is a boot partition. When UEFI is ready to run the boot loader, it reads this partition looking for a boot loader. This intiial  part of the boot loader will find the `/boot` partition that contains the GRUB2 software and load `core.efi` from and bring up the GRUB2 menu.

GRUB2 will boot the default kernel after a brief countdown. After picking the kernel you wish to boot into, GRUB2 will now find the kernel binary and then load a special file called `initrd.img` into memory. This file contains the drives your kenrl needs to load to make use of the hardware of host.

After loading `initrd.img`, GRUB2 completes and hands over control to the kernel, which continues the boot process by initiating your hardware, including hard disks. OS is started and a program called systemd, upstart or init is called that starts services and brings host to life. 

There are two main boot loaders: LILO and GRUB. GRUB2 is powerful and modern multiboot loader. A multiboot loader can enable host to boot into many different operating systems. GRUB2 allows to boot multiple versions of Linux, Windows and Mac OS X on a single hardware. GRUB2 is capable of booting in two ways. One is directly by finding and loading the desired kernel. GRUB2 also supports *chain loading* which allows to load another boot loader, such as loader for MS Windows which then loads desired OS kernel.

The GRUB2 loader is configurable and its configuration is contained in `grub.conf` file.  The GRUB2 files are located in different places on different distributions. On Red-Hat, CentOs, they can be found at `/boot/grub2/grub.cfg` and mostly symbolically linked to `/etc/grub.conf`. On Ubuntu and Debian hosts, the files can be found at `/boot/grub/grub.cfg`. On Ubuntu and CentOS, we will find the configuration files in `/etc/grub.d` directory. The GRUB2 configuration file is made via the `grub2-mkconfig` command. 

`sudo grub2-mkconfig --output mygrub.cfg`

It is highly recommended to set a password on your boot loader. CentOS has a tool that makes it easy to set password for grub2.

`sudo grub2-setpassword`

This actually creates a file `/boot/grub2/user.cfg`. To remove teh passwrod, remove the `user.cfg` file.

After boot, Linux starts initialization `init` program and birngs the system upto a known state. Most distributions now use `systemd` service. It is newer approach to system initialization. It will have PID 1. On Ubuntu, `/sbin/init` program is PID 1. 

### Systemd Process

Systemd is the newest system initializer and is the replacement for both SysV Init and Upstart. It has advantages such as:
- event driven
- concurrent and parallel boot processing
- respawn processes
- event logging
- tracks processes via kernel's CGroups

Systemd doesn't have runlevels like SysV but instead has "targets". Targets are used to group service dependencies together.Systemctl tool is the utility tool used to manage systemd. Rsyslog is the logging service on Linux.

SysV Init had a concept of runlevels. Runlevels define what state a host should be in at a particular point. Each runlevel comprises a set of applications and service and an indicator of whether each should be started or stopped. SysV has seven runlevels ranging from 0 to 6 and each distribution uses different runlevels for different purposes. 
Runlevel 0 : shuts down the host and brings the system to halt
Runlevel 1 : Runs in single-user mode (maintenance), command console, no network
Runlevel 2, 4: unassigned
Runlevel 3 : Runs in multiuser mode, with network, starts level 3 programs
Runlevel 5 : Runs in mutiuser mode, with network, X Windows (KDE, GNOME) and starts level 5 programs
Runlevel 6 : Reboots the host

All processes on Linux originate from a parent process. Forking a process involves parent process making a copy of itself, called a child process. With Systemd, the systemd process would be parent. This means that processes can persists without running to be attached to a console or user session. When the parent process stops, so do all its children.

Systemd has a command tool called `systemctl`, used to manage systemd resources on a local, remote or virtual containers. To start, stop and restart a service, we can use systemd utility.

```shell
sudo systemctl status|start|restart|stop postfix.service
sudo systemctl enable|disable postfix.service
# list running services
sudo systemctl --type=service --state=running
sudo systemctl poweroff
sudo shutdown -h now
```

Process can accept signals from the kill command. A TERM or SIGTERM signal tells a process to finish up what it is doing and exit. We can also send harsher signals like SIGKILL which will exit the process immediately. SIGHUP can sometimes be used to reload configurations of running processes.

Systemd is the process that manages all the services on host and systemctl is the command used to manage the systemd process. 

**Systemd Timers** are unit files with file extension `.timer`. They control when a service is run. It has advantages over Con that it can trigger events based on not only wall clock but also things like the period after teh last event was run, on boot, on startup or a combination of these sorts of things. Theses files are usually in  `/lib/systemd/system/apt-daily.timer` location.

```shell
// /lib/systemd/system/apt-daily.timer
Description=Daily apt activities

[Timer]
OnCalendar=*_*_* 6,18:00
RandomizedDelaySec=12h
AccuracySec=1h
Persistent=true

[Install]
WantedBy=timers.target
```

OnCalendar option specifies the time when it will run. It is in format day of the week, year, month, day and then hh:mm:ss or any other way. Look up `man 7 systemd.timer` for more options. It is triggered at 6:00 or 18:00 with 12 hour random window with accuracy of 1 hour. The Persistence=true means to run if the last start was missed.

**Cron** is service management used for scheduling. Cron jobs are defined in a series of scripts under the directories defined in `/etc/crontab` file. These are referred to as system cron jobs.

`42 4 1 * * root run-parts /etc/cron.monthly`

Crontab will run the last line at 04:42am on first day of every month. If we want to specify day of the week, we can specify using 0 to 6 where 0 stands for Sunday.

`*/2 4 1 * 3 root run-parts /etc/cron.monthly` runs the job every time the number of minutes is cleanly divisible by 2. This means it runs every 2 minutes.

The use of comma means a list of values, for example `2 0,1,2,3,4 1 * * root run-parts /etc/cron.monthly` would run the job at 12:02am, 1:00am, 2:00am, 3:00am and 4:00am. We can also specify range of values with hyphen(-).

`2 0-4,12-16 1 * *` would run at 2 minutes past every hour between 12:00am to 4:00am and between 12pm to 4pm. The next column *root* is user that this program will run as. The *run-parts* option is the command that is being run. It is special command that will run any executable script within a specified directory. It will change to `/etc/cron.monthly` and run any executables found there. 

We can create and edit existing crontabs using `crontab -e` command. If the crontab for your user does not exist already, this creates a crontab file in `/var/spool/cron/username`.

`crontab -l` command lists cron jobs. As a superuser, we can view another person's cron by using `-u` option.

`sudo crontab -u username -l`

To edit user's cron, use `-e` option.
`sudo crontab -u username -e`

To remote user's cron, use `sudo crontab -u username -r`. This removes user's crontab file from `/var/spool/cron/username`. There is a service called *crond* that manages and executes the jobs. It can be started and stopped using systemctl.

`sudo systemctl start|stop|reload crond`