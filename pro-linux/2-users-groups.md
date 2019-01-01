# USers and Groups in Linux

When we login to Linux machine, an application called `login` is executed and peforsms the following.

1. Checks that the user and group exist and the user is allowed to login.
2. Checks that the user is allowed to login from a particular location (Only some users can log in to the console, or the screen attached to Linux host)
3. Checks that the password is correct, and if the password is incorrect, allows a specified number of retries.
4. Checks that the password is valid and prompts the user for new password if a password has expired.
5. Sets environment variables like the user's home directory and path.
6. Starts the shell process and presents the user with a command-line prompt or GUI screen.

There are couple of ways to organize the users and groups on host. One way si to add users and groups to each host in the domain, the otehr is to centralize user administration on one or two authentication servers. Every user on Linux also needs to belong to at least one group but an belong to any number of additional groups as well. 

When applications are installed, they often install additional users and groups required to run thsoe applications. Users and groups can be created with the help of `useradd` and `groupadd` commands. We can modify existing users and groups using `usermod` and `groupmod` commands. For deleting, use `userdel` and `groupdel` commands.

The `sudo` command allows a user to run commands as if that person were signed in as the root user. This is useful as it increases security, allows greater control of privileged commands, provides with better audit trail to understand who did what on the host.

When you run `sudo` command, it will prompt to enter password (to confirm you're actually who you say you are), and then you are allowed ot make use of the sudo command for a period of 5 minutes on CentOS and 15 minutes on Ubuntu. We can enable sudo access for other users by adding them to the `admin` group. 

`sudo usermod -G admin <username>` to add a user to admin group. The only user allowed to use sudo action is the user created when installing the system. If the user is not created as an administrator on CentOS, the sudo command is not enabled by default. To enable, we need to use a command `visudo` to edit the configuration `/etc/sudoers`. For this login as root user and run `visudo` command. Inside the opened file you'll see:

`# %wheel ALL=(ALL) ALL`

We need to uncomment that line and then use `usermod` to add the group of admin to the user.

`usermod -a -G wheel <username>`

We can also add multiple groups by separating them by comma(,).

For  creating user, we can use `useradd` command.

`sudo useradd -m -C 'John Smith' jsmith`

The `-m` option tells the host to create  home directory for the user. The format of the home directory will be like `/home/username`. The default home directory path can be configuredd  by updating `/etc/skel` (skeleton) directory. When a new home directory is created using `-m` option, then all the files contained in this directory are copied to the user's new home directory. The `-c` option adds a description of new user. This description is stored in `/etc/passwd` file. 

By default, the new user will be created disabled and wihout password set. The user's home directory is by default private. Here are some of the `useradd` command options.

- `-c` : add a description of the user
- `-d homedir` : user's home directory
- `-m` : create user's home directory
- `M` : do not create user's home directory (CentOS only)
- `-s shell` : specify the shell the user will use.

The new user will be created with a variety of defaults. These defaults come from `/usr/sbin/useradd` or `/etc/default/useradd` in Ubuntu. This file is already prepopulated when the OS is installed and can be modified.

`sudo /usr/sbin/useradd -D`

There are also system-wide defaults set for the system when the user logs in, as found in `/etc/login.defs` file. It contains things like the uid and gid ranges to use when creating users. The description of the defaults are as follows:
SHELL : the path to default shell
HOME : the path to user's home directory
SKEL : the directory to use to provide the default contents of a user's new home directory
GROUP : the default group ID
INACTIVE : the maximum number of days after password expiration that a password can be changed. A value of -1 disables this setting and a setting of 0 diables the account as soon as the password expires.
EXPIRE : the default expiration date of user accounts. This allows us to specify a date on which the account will be expired and disabled. This can be used for temporary accounts.

`sudo useradd -e 2018-09-15 temp_account`

Change user default using -D option:
`sudo useradd -D -s /bin/bash`

User's default shell can also be changed using `chsh` command. `chsh -l` on CentOS lists all shells and in Ubuntu look into `/etc/shells` file.

useradd -D defaults:

| Option | Description |
| -b path/to/default/home | Specifies the path prefix of a new user's home directory |
| -e date | default expiration date |
| -f days | number of days after a password has expired before the account will be disabled | 
| -g group | specifies default group |
| -s shell | specifies default shell |

The creation of a unique group for each user is called a user private group (UPG) scheme. It is a flexible model for managing group permissions. This group is also called primary group. A user can also belong to other groups called supplementary groups. We can use `id` command to find the groups for a user.

`id <username>`

Each user and group is assigned a unique user ID (uid) and a gid when created. They can range from 0 to 65535. `id root` gives the uid and gid for root user. Each user and group must have a unique UID and GID. A user or group cannot be created on host with the same ID. OS will automatically assign the numbers and prevent any conflicts. Most distributions reserve ranges of numbers  for particular types of users and groups. There are two kinds of users: system users, users that run services, the other kinds of people who need to log into the system. CentOS reserves the UID and GID ranges of 1 to 200 for assigned system UIDs like apache. UIDs from 201 to 999 are for dynamically assigned system UIDs - these are daemons that have not defined UID and will pick a UID at installation. This is done by specifying the `--system` option when creating the user.  Normal users are created with UIDs of 1000 and above. We can control the range of UID and GIDs that are provided to users in the `/etc/login.defs` file. Edit the UID_MIN and UID_MAX range for UIDs and similarly for GIDs. We can alos set the SYS_UID_MIN and SYS_UID_MAX as well.

There are two methods of adding user to a group or groups. One is during creation of user and second is using `usermod` to modify user's group.

```shell
sudo groupadd printing
sudo groupadd finance
sudo useradd -m -C 'Anne Taylor' -G printing,finance ataylor
# we can specify the groupid using '-g' option for groupadd
# add another grouop accounts to ataylor user.
sudo usermod -a -G accounts ataylor
# Changes won't take effect until user logs out and logs back in
sudo userdel ataylor
# userdel command deletes the user, but doesn't delete the user's home directory.
```

`gpasswd` allows us to delegate responsibility for managing groups and their memberships. We can assign a particular user rights to add or remove users to a particular group.

We can force `userdel` to delete user's home directory using `-r` option.
Removing a user who owns files will result in user's objects without username.  It is usually better to disable a user rather than deleting it. We can run `find / -user UID -o -group GID` to find all the files associated with the user we deleted. To delete a grouop, use `sudo groupdel finance` command.

In Ubuntu, there are two alternative commands.

```shell
sudo adduser ataylor
sudo adduser username groupname # username and groupname must already exist
# these scripts can be configured using /etc/adduser.conf file.
```

When we create accounts via the command line, no password is set for the account. To set the password for the first time or to change the password, we use `passwd` command. On most distributions, basic password checking is performed to prevent you from providing weak or easy password like:
- password length of four characters
- Not a palindrome
- Not the same as the previous password with a case change
- combination of characters (alphanumeric)

We can change password of other users if we run this command as root user.

`sudo passwd jsmith`

**Password aging** allows to specify a time period during which a password is valid. After the time period, the user will be forced to choose a new password. We should set password expiration time properly so that user don't have to change it again and again and they won't need to write the password somewhere.

There are two ways to handle password aging. One is using command line `chage` utility.

`sudo chage -M 30 ataylor`

Here `-M` option set the password expiration period for specified user to 30 days. The chage command has different flags to specify the expiration period.

| Option | Description |
|:--------|:-----------|
| -m days | sets the min number of days between password changes. Zero allows the password to be changed at any time |
| -M days | sets the maximum number of days for which a password stays valid |
| -E date | sets a date on which the user account will expire and automatically be deactivated. |
| -W days | sets the number of days before the password expires that the user will be warned to change it. |
| -d days | sets the number of days since Jan 1, 1970 that the password was last changed. |
| -I days | sets the number of days after password expiration that the account is locked. |

In Unix, Jan 1, 1970 is also called epoch time. It is used as a measure in seconds since January 1, 1970. We can find Unix time using `date +%s`.

`sudo chage ataylor` will allow us to change all the options in single command interactive mode. We can use `chage -l <username>` to list when the password is due to expire.

Another method to handle password aging is to set defaults for all users in `/etc/login.defs` file. The following snippet sets the maximum password age to 60 days, minimum password age to 0 days and provide warning before 7 days.

```
PASS_MAX_DAYS   60
PASS_MIN_DAYS   0
PASS_WARN_AGE   7
```

A root user can enable or disable user accounts using `-l` option.
`sudo passwd -l <username>` would lock the user and prevent user from logging into the host using password. To unlock use `-u` option. However, this doesn't fully disable the user as user can still login using password-less authentication using SSH.

`sudo passwd -u <username>`

There is another way to totally disable access to the user that uses `usermod` command with `--expiredate` option. This sets the account expiration date to January 1, 1970 and disblaes the account immediately.

`sudo usermod --expiredate 1 <username>`

We can also set the login shell to `/bin/false` or `/usr/sbin/nologin`. This diables the user's getting shell access.

`sudo usermod -s /bin/false <username>`

We could also set the user's shell to `/bin/mail` command which is a small command-line mail reader. When user logs on, she can access only that command.

### Storing User Data

Linux distributions store details of users, groups and other information in three files on host: `/etc/passwd`, `/etc/shadow` and `/etc/group`. We don't need to edit these files as they can be edited using different commands. If we use other forms of authentication such as Network Information Service (NIS), Lightweight Directory Access Control (LDAP) or Active Directory, then host will usually query one of these authentication stores to confirm user exists and is allowed to login.

The `/etc/passwd` file contains a list of all users and their details. It includes:

`username:password:UID:GID:GECOS:Home Directory:Shell`

The username can be upto 32 characters and password with `x` means password is stored in `/etc/shadow` file. The GECOS contains data such as the name of the user, office location, phone numbers. If more than one item, they are separated by command(,). If the default shell is set to nonexistent file, then user will be unable to log in. If the shell is set to `/sbin/nologin`, then the user is stopped from loggin in and also logs the login attempts to `syslog` daemon. The syslog daemon is Linux logging server. It receives log entries from the OS and applications and writes them to `/var/log` directory.

Earlier password were stored in `/etc/passwd` as encrypted string. This had limited security as it can be cracked using brute-force attack. Due to weak security, modern computer can crack a simple password in minutes. Shadow passwords help reduce this risk by separating users and passwords and storing the password as a hash file `/etc/shadow` file. By default SHA512 hashes are used which are harder to break. The `/etc/shadow` fiel is owned by the root user. Shadow file also incldues components like passwd file separated by colons.

`username:pssword:date password last changed:min days between password changes:password expiration time in days:password expiration warning period in days:number of days after password expiration that account is disabled:date since account has been disabled`

The password is encrypted, two types of characters can telel about the status of the user account with which the password field can be prefixed. If the password is prefixed with ! or *, then account is locked and the user will not be allowed to log in. If the password field is prefixed with !!, then a password has never been set and the user cannot log in to the host.

On Linux hosts, information about groups is stored in `/etc/group` file.

```
root:x:0:root
ataylor:x:501:finance,printing
```

The `/etc/group` file is structured similar to `/etc/passwd` file. It includes information as `groupname:password:GID:member,member`. The password in group file allows a user to log in to that group using `newgrp` command. If shadow passwords are enabled, then passwords in the group are replaced with x and the real passwords are stored in `/etc/gshadow` file.

Login screen is the first thing the user see. It's good idea to put some important messages in that screen. To do this, we can edit the `/etc/issue` and `/etc/issue.net` files. The issue file is displayed when we login via the command line on host's console and the `issue.net` file is displayed when we login to the command line via an SSH session. We can set the message as follows.

```
^[c
\d at \t
Access to this host is for authorized persons only.
Unauthorized use or access is regarded as a criminal act
and is subject to civil and criminal proseution. user
activities on this host may be monitored without prior notice.
```

The `^[c` character clears the screen and `\d` and `\t` display the current date and time on the host, respectively. In addition to these files, `/etc/motd` file's content display directly after a commandline login.

After users have been authenticated and authorized, their shell is started. Most users eventually tweak every aspect of their shell environment to help them work faster and more efficiently. The bash shell reads its initial configuration from the `/etc/profile` file. This file usually contains references to other global configuration iles and is used to configure bash for all users on the host except the root user. Finally any cofiguration files in the user's home directory are processed. The `.bash_profile` and `.profile` files are commonly used and each user will have these in his home directory. We can find other cofiguration files by looking at INVOCATION section of bash man page.

The main  reason for customizing shell is to set environment variables. These act as default options that are used by many applications. They can define characteristics like preferred text editor, language, colors.

| Name | Used for |
|:-----|:--------|
| HOME | user's home directory |
| LANG | defines which language files applications should use |
| LS_COLORS | defines colors used by the `ls` command |
| MAIL | location of the user's mailbox |
| PATH | colon-separated list of directories where shell look for executable files |
| PS1 | defines normal prompt |
| SHELL | current shell |
| - | contains the last command executed in this session |

We can change prompt by setting PS1 variable in this file.

`PS1="[\T] \u@\h:\w\$ "`

This is how we can add directory to the PATH variables. This change is available only during this session.
`PATH=/home/user/scripts:$PATH`

If we want to set this permanently, place them in `.bash_profile` file in home directory.

```shell
PATH=/home/user/scripts:$PATH
export PATH # propogate the changes, make changes to other active sessions too.
```

To make a path or other environmental changes for all users, add the changes to the `/etc/profile` file or add those to a file in the `/etc/profile.d` directory. This file is used by all users (except root user). Use the `.bash_profile` in `/root` directory to modify the root user's variables.

**Aliases** allow to create shortcuts or set default options for often-used commands. 
`alias ll='ls -lah'`. We can also make alias permanent by adding it to `.bash_profile` file. To get the list of all aliases in your shell, run the `alias` command without any parameters. To delete an alias, use `unalias ll` command. 

## Controlling Access to Host

We can control a lot of user characteristics, when and how users can log in, what their passwords look like and how often they have to change and reset their passwords. These controls are checked when users log in to host and are managed by series of modules. These are called **Pluggable Authentication Modules(PAM)**. PAM was originally designed by Sun Microsystems to provide plug-in authentication framework. A large number of PAM exists to perform variety of functions ranging from checking passwords to creating home directory. Rather than having to rewrite each application for new authentication methods, we need to add PAM support. PAM takes care of the authenticating through a standard API.

PAM is a hierarchy of authentiaction and authorization checks that are performed when an application wants to perform some action. These checks are stacked together like when logging in we check the user exists, then check that user's password is valid, then that the password hasn't expired. This stack is made up of multiple PAM modules. On most Linux distros, two possible locations for PAM configuration information. The legacy file `/etc/pam.conf` is used to hold PAM configuration, but now it is generally available as `/etc/pam.d` directory. This directory usually holds collection of configuration files for PAM-aware services. These files are called service configuration files. 
There are variety of service configuration files - for example, *login* when a user logs in. It contains authentication configuration for the application. If we look at login PAM file, we can see four major management groups in PAM.

- auth: these modules perform user authentication, checking a password.
- account: this group handles account verification tasks, for example, confirming that the user account is unlocked or if only the root user can perform an action.
- password: these modules set passwords, checking and ensuring that password is sufficiently strong.
- session: these modules check, manage and configure user sessions.

Usually one or more modules are assigned to each management group and are checked in the order they are specified. Each module will return either a success or failure result. 

```
auth        sufficient      pam_unix.so nullok  try_first_pass
account     required        pam_unix.so
password    sufficient      pam_unix.so m5  shadow  nullok  try_first-pass  use_authtok
session     required        pam_unix.so
```

This indicates that pam_unix.so is the moduels that takes care of most standard Univ authentication functions. The next directive sufficient is control flag. Control flags tell PAM what to do with the success or failure result and how that result impacts the overall authentication process.

required: A required module must succeed for authentication to succeed.
requisite: If a requisite module fails, then authentication will immediately fail.
sufficient: Authentication immediately succeeds if the module is successful
optional: success or failure of the module doesn't impact authentication process to succeed. If the result of this module is failure, then overall authentication is also a failure.

The next directive pam_unix.so, indicates what PAM module will be used and its location. If you specify a PAM module without a path, then the module is assumed to be located in `/lib/security` directory.

The `include` functions allows to include one PAM file in another. This is how common configuration is included in specific service configuration files. 

```shell
@include common-auth
@include common-account
@include common-session
@include common-password
```

`su` command allows to switch user. With `sudo su <username>`, we don't need password for the user as we are running this as sudo. When using sudo command, it will prompt for a password. Then it will provide grace period of 15 minutes during which you don't need to enter password. 

When we are not allowed to execute sudo command, we receive a warning message like: 
*user is not in the sudoers file. This incident will be reported.*

A failed attempt to use the sudo command will be logged by host's syslog service and then message sent to `/var/log` directory. On CentOS, sudo command failures can be seen in `/var/log/secure` file. The messages allow us to monitor for people attempting to perform inappropriate actions on our hosts.

The sudo command checks `/etc/sudoers` file for authorization to run commands.  Using `visudo`, we can configure sudoeers file to restrict access to particular users, to certain commands, and on particular hosts. The `visudo` command is safest way to edit sudoers file. The command locks the file against multiple simultaneous edits, provides basic sanity checks and checks for any parse errors. If  it is being edited, you will receive a message to try later.

If we want to allow specific user to run specific command, we can edit sudoers files like this:

```
# username host=command
ataylor ALL=/bin/userdel
ataylor ALL=/bin/useradd,/bin/userdel
```

This allows ataylor user on all hosts, to use the command `userdel` as if she were the root user. We can also specify multiple commands separated by commas.

A sudoers file is designed to configure multiple hosts. It allows host-specific access controls. If we want to provide some commands access to user but those commands should be run as different user, then we can use:

`ataylor au-mel-centos-1=(mysql) /usr/bin/mysqld,(named) /usr/sbin/named`

The sudo command also comes with option of defining aliases. Aliases are collections of like users, commands and hosts. Generally aliases are defined at the start of the sudoers file. 

```shell
# this specifies list of users belonging to ADMIN alias
User_Alias ADMIN = ataylor,jsmith
# this specifies list of commands allowed for ADMIN alias users.
ADMIN=/bin/userdel,/bin/useradd,(named)/usr/sbin/named

# Cmnd_Alias which groups collections of commands.
Cmnd_Alias USER_COMMANDS=/bin/userdel,/bin/useradd
# All users in ADMIN alias can run groupadd, useradd, userdel on ALL hosts.
ADMIN ALL=/bin/groupadd,USER_COMMANDS

# define Host_Alias
Host_Alias SERVERS=au-mel-centos-1,au-mel-centos-2
ADMIN_SERVERS=USER_COMMANDS

# we can also negate aliases by placing exclamation mark (!) in front of them.
# Here username will have access to all commands in /bin/ but DENIED_COMMANDS
Cmnd_Alias DENIED_COMMANDS=/bin/su,/bin/mount,/bin/umount
<username> au-mel-centos-1=/bin/*,!DENIED_COMMANDS
```

Another way to authorize users to use sudo is inside **sudoers** file, we can define another type of alias based on group information in the host by prefixing with %.
This means all members of the defined group are able to execute whatever command we authorize them (here ALL commands on ALL hosts)
`%groupname ALL=(ALL) ALL`

On CentOS, a group called wheel exists which is similar to this. We need to uncomment the line in `/etc/sudoers` file. On Ubuntu this group is called `admin`.

`%wheel ALL=(ALL) ALL`

We can define to change the behavior of sudo command. We can configure sudo to send email when the sudo command is used. We use the following line to define who to send email to.

`mail to "admin@au-mel-centos-1.yourdomain.com`

We can also define when sudo sends email as follows.

`mail_always on`

| Option | Description |
|:-------|:------------|
| mail_always | Sends email every time user runs sudo. `off` by default. |
| mail_badpass | Sends email if user running sudo does not enter the correct password. This is set to `off` by default. |
| mail_no_user | Sends email if the user running sudo does not exist in sudoers file. Set to `on` by default |
| mail_no_host | Sends email if user running sudo exists in the sudoers file but is not authorized to run commands on this host. Set to `off` by default. |
| mail_no_perms | Sends email if the user running sudo exists in sudoers file but does not have authority to the command he tried. `off` by default |

sudo command itself has number of options.

-l : prints a list of allowed commands for current user on current host
-L : lists any default options set in the sudoers file
-b : runs the given command in background
-u user : runs specified command as user other than root

Usually, the rules are logically grouped files and placed in the `/etc/sudoers.d` directory.

`sudo visudo -f /etc/sudoers.d/01_operators` 
This is where we should place things that are particular to the operators group. Sudo will look through the `/etc/sudoers.d/` directory and load any files it finds, in order.

### Auditing User Access

We need to keep track of actions the user is performing on resources. The `who` command displays all users logged on the host currently including the remote host if they are connected through SSH.

`sudo who`

`sudo last` will print report of last logins to the host including session duration. Similarly, `lastb` command creates similar report but only reports bad login attempts. The `lastlog` command displays a report that shows the login status of all users on host, including those users who have never logged in. The command displays a list of all users and their last login date and time.