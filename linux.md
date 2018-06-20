# Linux Operating Systems for Hadoop Administration

There are different installation options.
1. Minimal install - comes with console only
2. Compute Node - used for installation on cloud
3. Infrastructure Server - used to form infrastructure of different servers
4. File and Print Server - using server just to keep files and send to printers
5. Basic web Server - comes with minimal install and apache web server.
6. Virtualization Host - virtualization layer set up
7. Server with GUI - server infrastructure with GUI to enable learning.
8. GNOME Desktop - working desktop installation
9. KDE Plasma workspaces - similar to last one but only graphics are different
10. Development and Creative Workstation - used for designers


ls - list 
touch <filename> - create new blank file
man <command> - see the manual for a given command
ls -lh - list the file in human readable format.

### Setting Kernel Parameters

Linux Kernel is the core of the OS. It is the main process that talks to the hardware. When user send command to shell, it sends it to kernel and communicates the same to hardware. Kennel parameters allows the hardware in certain manner.

`ping <ip_address>` will give replies from the ip address when system is available on the network. We can also disable this by changing kernel parameters. We can set kernel parameters to not respond to USB drives.

Linux boot process involves: power on the SMPS, BIOS (basic input output system) contains information about all hardware components and it fires them up and let the OS know which components are connected. If BIOS fails to load Grub, it would report 'Missing Operating System'
Load stage 1 Grub from MBR. Linux has bootloader. Before Kernel comes in bootloader talks to hardware. This is also called Grub. It loads from Master boot record, available in first sector of harddisk. It reads partition table, knows the partition.
It reaches stage 1.5 where it displays menulist - here it lists which OS are available. If something goes wrong, it would not move forward. 

If everything is fine, then it would list all available OS. (menu.list)
After this it loads Kernel image and initial RAM disk. If there is something wrong, it would report 'File not found'
After this Kernel mounts the root file system and runs `init`. If mounting of root file system fails, it would just freeze.
`init` runs scripts to start user-level services.

User can interact with Shell and shell interacts with Kernel. Shell is an interpreter for user commands.

`echo $SHELL` shows which shell we are using.

`sysctl` is an interface that allows us to make changes to running linux kernel. At the time of booting again, the settings would disappear. To keep these settings, we need to write our settings to `/etc/sysctl.conf`.

Real time kernel parameter data is stored in `/proc` directory. Particularly `/proc/sys` is where you can find all the information about devices, drivers and kernel features.

```shell
man sysctl
vi /etc/sysctl.conf
sysctl -a # list all kernel settings
sysctl -a | wc -l # count number of lines for these parameters
cat /proc/sys/net/ipv4/ip_forward # shows ip forwarding option
echo "0" > /proc/sys/net/ipv4/ip_forward # turn off ip forwarding
# To make this setting permanent, we have to write this option in `/etc/sysctl.conf` file.
sysctl -p # reloads the `sysctl.conf` options.

# To stop accepting ping requests
vi /etc/sysctl.conf
net.ipv4.icmp_echo_ignore_all=1 # ignore ipv4 requests
sysctl -p # now ping will not work for this machine.
To revert, set it to 0 again.
