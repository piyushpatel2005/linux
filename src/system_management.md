# System Management

## Package Sources

In `etc` folder, you have all configuration for System. Inside `etc/apt/sources.list` we have list of where we can get software.

You can get latest software updates using:

`sudo apt-get update`.

Then upgrade,

`sudo apt-get upgrade`

**Note:** `apt` takes care of all the dependencies.

- To search in apt:

`apt-cache  search <package name>`

`apt-cache search codeblocks`

- To install new programs:

`sudo apt-get install <program name>`

- To remove programs:

`sudo apt-get remove <program name>`

It doesn't remove package dependencies.

- Remove unnecessary packages, which are no longer required:

`sudo apt-get autoremove`


---
## Logging and Log Management

Logs are useful for troubleshooting and other tasks.

To look at configuration file for syslog:

`etc/rsyslog.conf`

If any of the system has problem, look into `var/log` directory with `cat syslog`

---
## Services

All the services in Ubuntu are scripts.

They are in `etc/init.d`. It is source for all scripts.

To check the services

Go to `etc./init.d/` and run the command

`sudo service --status-all`

It will list all scripts in `init.d`

  - (-) means service not running
  - (+) means service is running
  - (?) means response was not clear.

We can stop a service using

`sudo service <service name> stop`

We can start using

`sudo service <service name> start`

To check if service has started or not:

`ps auxw | grep <service name>`

---

## Processes Management

Any running program is a process.

- Show current Process

`ps`

- To see all Processes

`ps aux`

To narrow down the list to specific program.

`ps aux | grep <program name>`

For example, `ps aux | grep firefox`

To see the updates of processes running in realtime. Use,

`top`

- To kill a process (if stuck or if doesn't have close option)

`man kill` - to see manual for kill.

- To get process id:

`ps aux | grep firefox`

- To kill a process:

`kill <process id>`

- To kill by name:

`killall firefox`


---

## Building Software (make):

To build from source, follow this process.

Download src file.

Extract source file.

`tar xzvf <filename>`

`cd <dirname>`

Then run `./configure`.

At the end, we will have `Makefile`.

`make` will make file.

To install software now.

`make install`

---

## Useful Utilities:

**grep** Global Replace - It can be used to search for string patterns and files.

`grep file *`

will search any file in the current directory.

`grep -R file *`

will search every file recursively. It search even inside any directory withing current directory.

`ps aux | grep bash`

will get process list and then pass it to grep process to search for `bash`.

'|' character is used to pass the output of one process to another. pipe character.

For example,

`apt-cache search apache | grep php`

**sed** Stream Editor

Try these:

`echo This is true`

`echo This is true | sed 's/true/false/'`

**cron** is used to automate tasks

`cd /etc/cron.d`

`ls`

`cd ../cron.daily`

is where you will put jobs that you run once a day.

There are `cron.hourly`, `cron-weekly`.

Just put a script in required directory and it will execute automatically in alphabetical order.

`sudo` is used to have administrative privileges.


---

## Kernel Modules

Kernel interacts with Hardware. We can find kernel modules in `/lib/modules/<version>-generics/kernel`.

`lsmod` lists running Kernel modules at this time.

`rmmod` can be used to remove a module.
`insmod` can be used to insert a module.

---

## User Management

`sudo /etc/passwd` would display all users.

`sudo cat /etc/shadow` would show password in hash.

`/etc/group` is used to display groups.

To add user to a group we can use `useradd` command.

To change user group, we can use `usermod` command.
To delete the user from a group, we can use `userdel`.

To change password:

`passwd`

- To add a user to a group, edit `/etc/group` file and add the username at the end of ':'.

- To add new group

`sudo groupadd <group name>`

- To change group `groupmod` can be used.
