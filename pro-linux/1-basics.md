# Basics of Linux

Some distributions of Linux allow us to login as root user. `sudo` command allows us to run commands with the privileges of the root user without logging in as that user. Recently new security controls have been introduced to provide more granular security controls. These include tools like SELinux and AppArmor.

```shell
whoami # returns the name of the user you are logged in as.
```

Bash keeps track of command history which we can navigate using up arrow key. The amount of history kept is user-configurable and can be manipulated using `history` command. We can retrieve specific command by running specific numbered command using `!12` for example which runs 12th command on history.

By default most distributions set the default path, usually containing the typical locations that contain executable binaries. If required, this path can be updated using environment variable $PATH. Try, `echo $PATH` to see what environment variables are setup.

## Remote Access

With Linux, it is easy to remotely connect to the hosts so that we can administer and manage them. There are different menthods for setting up remote connection. These includes desktop sharing protocol like VNC (Virtual Network Computing), Remote Desktop Protocol(RDP).

### SSH connection
SSH is both an application and a secure protocol used for a number of purposes but primarily for remote administration of hosts. In Linux, SSH is provided by open source version OpenSSH. SSH connects over TCP/IP networks in a client-server model. Remote connections using SSH are encrypted and require authentication, either password or public key cryptography. To connect to remote host from your laptop, your laptop is client and remote host is server and you need to know IP address or hostname of the remote host. Client connects to the server via TCP on port 22. Ports are communications end points used by services like SSH. Port numbers range from 0 to 65535 with some common ports include 80 for HTTP, 25 for SMTP, 21 for FTP. Ports between 1 and 1023 are reserved for system services while ports 1024 and higher are more arbitrarily assigned.

After initial connection, the client is prompted by server for username and authentication credentials. If the user exists on the server and the correct credentials are provided, the client is allowed to connect. SSH daemon on server allows remote connections to be made to the command line or GUI of the host. These daemons are running by default.

To connect, use command like `ssh username@hostname`. On Windows, we can use Putty client to connect to remote hosts. First time when you try to connect to host you have never connected to, it will prompt to accept the RSA key fingerprint. This is from SSH server you are connecting to. After you accept this key, it is stored against the server name in a file called `known_hosts`. Every subsequent connection to this host will check the fingerprint to see if it is changed. If it has you will be asked to clean the key before reconnecting. This gives the opportunity to verify if host or your communication has been tempered with.

## Getting Help

We can get help for any command using manpages. We can type `man <command>` to know more about a command. If you don't find man pages for a command, try `--help` swith as  `ls --help`. We can search for relevant manpages that match words in their short description.

```shell
man -k user # searches manpages which has user in their short description
man -K user # search all man pages for a keyword using this option
whatis useradd # searches summary database of commands that most distributions has
apropos whoami # searches whatis database but searches for strings rather than complete command. So, it can return multiple results.
info ls # provides more information about command
```

### Users and Groups

Linux is a multiuser system and allows multiple users to connect to the host and use its resources. Users are also created for particular systems components and used to run services; for example, if you install a mail server, a user called mail might also be created that is used with this service or a user called lp for printer.
Linux also has groups which are collections of like users. Users can be members of one or more groups and are usually placed in a group so they can access some kind of resource. User and group information is primarily contained in tow iles `etc/passwd` and `etc/group`.

### Services and Processes

Services can be started stopped and often have to be restarted when an application is reconfigured. These services are called daemons and run many of the key functions on host. Each service or daemon is one or more processes running on host. These processes have name like sshd. Other common services include `master`(the Postfix mail server), `httpd`(the Apache web server) and `mysqld` (MySQL database server). Most daemon processes ually have name ending in "d" for daemon. The `systemd` processis the base process on Linux hosts that spawns all other processes on a host. This process always uses PID 1 and must be running for host to be functional. Some distributions have similar process but named `init`, usually in older systems.

Many processes whose name starts with "k" are not real processes, but kernel threads. These threads are special kind of service that performs management tasks in the core of the OS, kernel. The light weight processes allow the kernel process to run different tasks in the background which can listen for specific events. Similarly, `top` commands starts an interactive monitoring tool that updates every few seconds with top running processes on host. This output also includes system uptime, system load averages, CPU usage and memory utilization.

```shell
ps -A # list all processes
top # list processes that consume more resources, for system monitoring
```

In Linux, applications are bundled as packages and they contain required binaries, supporting files and often configuration files. In Linux, everything is a file or a process. `/` is the root directory. If you want to execute any command, we can add `./` in front of the command.

```shell
pwd # prints working directory
cd / # change directory to specified directory.
cd .. # traverse one directory up
ls foo* # show files starting with foo
ls foo? # show files starting with foo plus one character
```

Below tables shows some of the common directories in Linux. All of these may not be available in some distros.

| Directory | Description |
|:---------|:------------|
| /bin/ | User commandsd and binaries |
| /boot/ | Files used by the boot loader |
| /dev/ | Device files |
| /etc/ | System configuration files |
| /home/ | User's home directories |
| /lib/ | Shared libraries and kernel modules |
| /media/ | Removable media is mounted here |
| /mnt/ | Temporary mounted filesystems are mounted here |
| /opt/ | Add-on application software packages |
| /proc/ | Kernel and process status data is stored here |
| /root/ | The root user's home directory |
| /run/ | A directory where applications can store data they require to operate |
| /sbin/ | System binaries |
| /srv/ | data for services provided by the host |
| /sys | virtual filesystem that contains information and access to the Linux kernel subsystems |
| /tmp/ | Directory for temporary files |
| /usr/ | User utilities, libraries and applications |
| /var/ | Variable or transient files and data, for example, logs, mail queues and print jobs. |
| /var/log/ | directories created by various applications using host's syslog daemon. These log files contain information about the status of applications, daemons and services. |


To see long listing of files with inclusion of hidden files use `ls -la` command. This lists Unix file type, Permissions, Number of hard links, User and group, Size, Date and time, Name.

### File Types and Permissions:

Everything in Linux is described as a file. The first character of the listing tells us what sort of file it is.

| Type | Description |
|:-----|:------------|
| - | File |
| d | Directory |
| l | Symbolic link (used to make the file appear at multiple locations) |
| c | Chracter devices |
| b | Block devices |
| s | Socket |
| p | Named pipe |

The `b` and `c` types are used for different types of input and output devices (usually appears in `/dev` directory). Devices allow the OS to interact with particular hardware devices. Sockets and named pipe allow interprocess communications of varying types. They allow processes to communicate with each other.

The next nine chraracters detail the access permissions. There are three permission, read, write and execute. There are two other types of permissions, sticky and setuid/setgid permissions represented by `t` or `s` characters respectively.

Read permissions allow a file to be read or viewed but not edited. If set on directory, the names of files in directory can be read, but not other details. Write permissions allow to make changes or write to a file. If set on directory, you can create, delete or rename files in directory. Execute  permissions allow you to run a file, all binary files and commands must be marked executable to allow you to run them. If set on directory, you are able to traverse the directory by using cd. Each permission strings is for user, group and others. Permissions can be changed by two ways, by specifying user, group or other and change in permission one at a time or by using hex code for permission which can set three permissions in single command.

```shell
-rw-r--r--  1 root  root  0   2016-07-15 20:47 myfile
# root user has read and write permissions
# root group has permission of read
# others have permission of only read
chmod u+x myfile # give user a permission to execute
chmod u+x, og+w myfile # give user executable and other, group  write permissions
chmod 654 myfile # set permission string as octal representation
chmod a+x myfile # provide executable permission for all users
chmod u=g myfile # apply permissions of group to user class.
chmod -R u+x /usr/local/bin/* # apply permissions recursively
```

Here + sign represents adding permissions. Similarly, we can revoke permission using minus (-).

There is a concept of `umask`, it dictatest the default set of permissions assigned to a file when it is created. Without umask set, the files are created with permissions of 0666 and directories are created with permissions of 0777. We can use umask to modify the default permissions.

`umask 0022` It indicates what's not being granted. So, if we had a default permission of 0666 and subtract 0022 value, leaving with permissions of 0644. With umask of 0022, a new file would be created with read and write permissions for the owner of the file and read permission for group and others. with umask of 0002, which results in default permissions of 0664 for files and 0775 for directories.

On most hosts, umask is set automatically by a setting in shell. For bash,  we can find the global umask in `/etc/bashrc` file, but this can be overridden per-user basis using umask command or using `pam_umask` module.

The **setuid and setgid** permissions allow a user to run a command as if he were the user or grouop that owned the command. This allows users to execute specific tasks that they would normally be restricted from doing or allows users to share resources, like accessing shared files on a fileserver with the same group id. The `passwd` command allows a user to change her password. To do  this, the command needs to write to the password file which has restricted access. By adding setuid permission, a user can execute the passwd command and run it as if she were the root user, hence allowing to change password. These permissions can be recognized for setuid or setgid using `s` or `S` in the listing of permissions.

`-rwsr-xr-x 1 root  root  25708 2016-09-25 17:32  /usr/bin/passwd`

If a directory has permission of `-rwSrwSr--` means the user does not have execute permissions associated  with the user and group. These permissions are used sparingly as we don't want one user to be able to run applications as another user. They could also potentially be abused and represent a security exposure, they should not be used indiscriminately.

**Sticky permissions** are slightly different and are used on directories, they have no effect on files. When sticky bit is set on a directory, files in that directory can be deleted only by the user who owns them, the owner of the directory or by the root user irrespective of any other permissions set on the directory. This allows the creation of public directories where every user can create files but only delete their own files.  The directories with sticky permissions have `t` at the execute permission for other class. This is usually set on `/tmp` directory. In octal notation, setuid/setgid and sticky permisisons are represented by a fourth digit at the front of the notation like 6755. To set the sticky bit on a directory, you'd use an octal notation like 1755.If no setuid/setgid or sticky permissions are being set, this prefixed digit is 0.

After permissions, the number is the number of hard links to the file. **Hard links** are references that connect your file to the physical data on a storage volume. There can be multiple links to a particular piece of data. 

#### User, Groups and Ownership

Groups are used to allow access to resources; for example, all users who need to access a printer or a file share migth belong to groups that provide access to these resources. A user must belong to at least one group, known as the primary group, but can also belong to one or more groups, called supplementary groups. These user and group ownership of a file can be changed using `chmod` command. Only root user has authority to change the user ownership of a file.

```shell
chown piyush myfile # change owner of a file
chown piyush:admin myfile # change owner and a group of a file
chown -R piyush:admin /home/piyush/* # change owner and group of files recursively
```

There is also `chgrp` command to allow users  to change the group of the file they own. This can only change group ownership.

#### Size and Space

Get file size in human readable format. In these listings, the size of the directory is not the original size. To get the total size of all files in a directory, you can use `du` command.

```shell
ls -lh # human readable format
du -sh / # find total size of the directory
df -h # total disk space used and free on host
```

#### Date and Time

The final item in listing is date and time the file was last modified (known as mtime) and the name of the file or directory. Linux also tracks the last time a file was accessed (called atime) and when it was created (called ctime).

```shell
ls -lu # get listing with last accessed
ls -lc # get listing with created date
date # display actual time and date on current host
date +%s # display date as number of seconds from Jan 1, 1970
``` 

`date` has many other formats which can be viewed using man page.

`cat /etc/hosts` used to read a file. This file `/etc/hosts` contains host entries for our Linux host.
We can also use `less /etc/services` to see one page at a time. To see next page,  press Enter and to go back, press B.

`grep` command allows for searching a string in a file

`grep localhost /etc/hosts` will search 'localhost' in file `/etc/hosts`. This can be made case insensitive by adding `-i` switch to the command.

Recursively search down into lower directories by adding -r switch.
`grep -r localhost /etc`

We can also search using regular expression `grep 'J[oO][bB]' *`

`grep 'job$' *` will find all lines ending with job.
`grep '^job' *` will find all lines starting with job.

On Command line, we can also search for files using **find** command. find command can also be used to find files that doesn't belong to any user or group. This usually happens if the user or group has been deleted and associated files not reassigned or removed with that user or group.

```shell
find /home/ -type f -iname myfile*
find / -nouser -o -nogroup # find users with no username or group
cp /home/user/file ./file # copy files
cp -i file1 file2 # copy file interactive if file already exists at destination
cp -r /home/user /backup
mkdir dirname # create directory
mkdir -p dir1/dir2 # create complete path if not exists
rmdir dirname # delete empty directory
rm -rf dir # delete directory with files
mv file1 file2 # move file1 to file2
mv -i ~/file1 newpath/file2 # move file from one directory to another
cat filename > copyfilename
cat filename >> appendfile
```

We can also pipe the output of one command to another using pipe (|) symbol. We can also run multiple commands by separating them with semi-colon(;).

```shell
cat /etc/passwd | grep ataylor
cat *.txt | sort | uniq > text
# direct the file /etc/group into grep command using < symbol
# search accounts using grep and then used > to direct the output of this into a file called matched_accounts
grep accounts < /etc/group > matched_accounts
```

On Linux hosts, you can create links to files. Links can be hard links or soft links. If you delete hard links, it will delete the actual file as well. Hard links can be created on the physical partition or hard drive. We can't link to a file located on another device or partition. Symbolic links are very useful when you want to keep same file in two locations and do not want to maintain copies.

```shell
ln /home/piyush/myfile myfile # this creates hard link
ln -s /home/piyush/myfile myfile # this creates soft link
```

