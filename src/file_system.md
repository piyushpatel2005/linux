# File System

* List files in the current folder

```bash
ls
```

It would display different types of files and folders using different colors.

* List all files

```bash
ls -a
```

Dot files starting with (.) are considered system level files. They will not show up with simple `ls` command. They are usually configuration file.

* Long listing for all files

```bash
ls -la
```

* Get help for ls

```bash
ls --help
```

* To move into a directory, we use cd:

```bash
cd Desktop
```

will move into Desktop directory which is in the current directory.

* To run a file, we use:

```bash
./filename
```

where dot(.) represents the current file.

* To move to the parent directory

```bash
cd ..
```

* To move up two levels:

```bash
cd ../..
```

* To create new file:

```bash
touch <filename_with_extension>
```

* Get head or tail of the files

```bash
head <filename>
head -n 4 <file>  # first 4 lines from file.
tail -n 4 <file>
```

* Move file from one location to another

```bash
mv original_file to_new_location
```

* Similary cp for copy

```bash
cp file1 new_location
cp -r Documents Desktop # copy recursively
```

* Delete a file or directory

```bash
rm filename
rm dirname # works with empty directory
rm -r dirname  # works even if the directory is not empty, recursive remove
rmdir dirname # remove empty directory.
```

* Search manual page names and description

```bash
apropos <search>
apropos calendar
```

* Wild cards can be used to search or list something

```bash
ls *.jpg
ls 2017*
```

* Create file using **output redirection**

```bash
echo "I am a new file" > newfile.txt  # write new file by deleting original Content
echo "I am appending" >> newfile.txt  # append at the end of the file
```

* Search through text file

```bash
grep "xyz" <filename>
grep -i "XYZ" <filename>
```

* regular expression search

```bash
egrep "i.g" <filename> # would match Virginia, Niagra
egrep "s+as" <filename> # one or more occurences of 'as'
egrep "s*as" <filename> # zero or more occurences of 'as'
egrep "s{2}" <filename> # two 's'
egrep "s{2,3}" <filename> # two or three 's'
# Capturing group can be used to catch a group multiple times
egrep "(iss){2}" states.txt # Mississippi would match
egrep "(i.{2}){3}" states.txt # match i followed by two character  and there should be 3 occurences of such capturing group
# Mississippi 'iss', 'iss', 'ipp'

egrep "\w" <filename> # any word
egrep "\d" <filename> # digit
egrep "\s" <filename> # space character
egrep "\W" <filename> # non words
egrep "\D" <filename> # non digit
egrep "\S" <filename> # non space
egrep "[^aeiou]" <filename> # beginning with aeiou
egrep "[e-q]" <filename> # characters in range from e to q
egrep "[e-qE-Q]" <filename>

egrep "\+" <filename> # search meta character +
egrep "end$" <filename> # words that end with 'end'
egrep "North|South" <filename> # search North or South
egrep -n "the" <filename> # display line numbers where 'the' occurs
egrep "the" file1 file2 # search from multiple files
```

* Search file recursively from present directory using find command.

```bash
find . -name "README.md"
find /Pictures -name "*.jpg"
```

* Get history of commands

```bash
history
head -n 5 ~/.bash_history
grep "sudo" ~/.bash_history
```

* Difference between two files

```bash
diff file1 file2
sdiff file1 file2 # line by line comparison
```

* Pipes are used to pass the output to the next command

```bash
cat <filename> | head -n 5
grep "[aeiou$]" <filename> | wc -l # number of occurences of aeiou
```

You can see that you can do lots of stuff. You can sort files by word and time. You can print the files using human readable format

## File Permissions:

When we print the detailed file listing, the first column shows the file permissions

Linux uses dot (.) to represent current directory and dot-dot(..) for directory above(parent directory).

Set of permissions are shown by various characters. These are represented by bits.

First character: directory or file (d for directory, - for file)

Next three characters: permissions for owner. They are three characters (first for read, second for write and third for execute).

Next Three characters are for group of the file

Next Three charactesr are for all other users.

They are shown by rwx in representation.

* To change permissions, we can use:

```bash
chmod 744 <filename>
```

7 means 111 : rwx
4 means 100 : r--
2 means 010 : -w-

This is how the mod can be changed for files. Rememberr, read-write-execute

We can also set permissions using:

```bash
chmod g+x <filename>
chmod u+x <filename>
chmod o+x <filename>
chmod a+x <filename>
```

Add execute permission for group
Add execute permission for user (owner)
Add execute permission for others
Add execute permission for all three.

### Try following commands:

Try out these commands one at a time and notice the results to understand the operations in action

```bash
touch test.txt
ls -la test.txt
chmod u+x test.txt
ls -la test.txt
chmod u-x test.txt
ls -la test.txt
chmod a+x test.txt
ls -la test.txt
chmod a-x test.txt
chmod o+w test.txt
ls -la test.txt
chmod o-w test.txt # remove permission from all to write
```

* Print working directory

```bash
pwd
```

* Copy a file

```bash
cp <filename> <new-location>
```

Example:

```bash
cp test.txt ~/Downloads
```

* Check the file in Downloads folder:

```bash
ls -la ~/Downloads/
```

* Remove file

```bash
rm <filename>
```

**Note:** `rm` removes the file permanently. It doesn't go to Recycle bin. If you want to be sure, you can use `rm -i filename` which will prompt again before deleting.

```bash
rm ~/Downloads/test.txt
ls -la ~/Downloads/test.txt
```

* Move files

```bash
mv <filename> <location>
```

* Rename file

```bash
mv <filename> <new-filename>
```

```bash
mv test.txt test2.txt
```

## Path Variables

* Look up path variables, where system will look for programs or executables.

```bash
echo $PATH
```

All directories in Path variables are separated by coon(:).

To add new PATH we use export function. When setting path, we don't use '$'.

```bash
export PATH=$PATH:~/bin
```

This simply means set PATH variable using whatever $PATH variable + '~/bin'.

similar to `PATH = PATH + extraPATH`

## File Editing:

* Edit a file:

```bash
echo this is my file > test.txt
```

'>' is output redirection. Here redirecting the text to test.txt file.

* Concatenate files

```bash
cat <filename> <filename2> ...
```

**Nano** is a file editor for Linux.

* Open a file with Nano

```bash
nano <filename>
```

* Open file in vi Editor:

```bash
vi <filename>
```

## Pseudo File systems on UNIX

`/dev/` stores devices on the system. To access them, we use this folder to access various devices.

`/proc` file system is the processes running on the system. It represents separate folder for each process ids.

init has process id

`/sys` directory offers lots of settings for the OS.

* Which programs and where they are stored?

```bash
which ruby
```

gives the path where ruby is installed, if installed.

* Finding files

```bash
sudo find / -name "*logs*" -print
```

will return number of files that include logs word under the home (/) directory.

Look for help `find --help```.

* Redirection

You can redirect any output to anywhere. For example to redirect the output of a command, you can use '>'.

```bash
ls > ls.txt
```

would create new file `ls.txt` with the result of `ls` command on the current directory.

To append the results, we can use `>>`. If file doesn't exist, it will create file.

* To redirect the output of errors we can use:

```bash
<command> <output-stream> <filename>
```

```bash
find / -name hi -print 2> errors.txt
```

would move all the stderr results to errors.txt and would display correct results on the console. Here, 2> means redirect the error stream only to errors.txt

We can send the useless output to the `/dev/null`. It will never be visible or used.

To access files in the current directory, we use (.).

### Symbolic links:

Symbolic links are kind of new name for the same reference. For example, if you want to access deep file, you can create a simple linke pointing to that file or folder.

* To create Symbolic link

```bash
ln <source> <symbolic-name>
```

```bash
ln errors.txt errors
```

```bash
ls -la errors
```

would show 2 in the second column indicating that there are two references.

* To remove link

```bash
rm errors
```

Now `ls -la errors.txt` would show only 1 in second column. These are hard links.

To access deep folders, we can create links.
To create symbolic link we use `-s` flag.

```bash
ln -s /Desktop/programs/linux linux
```

Now, to access linux folder located inside programs folder, I can use `cd linux` which will take me to the same location directly.

### Compressions:

* You can zip using:

```bash
zip myzip.zip *.txt
```

* To unzip the files:

```bash
unzip myzip.zip
```

**Tar: Tape archieve** Bundling lots of files into a single file.

```bash
tar cf mytar.tar [files]
```

* To add compression, we use `z` and `v` for verbose

```bash
tar cfzv mytar.tar.gz *.txt
```

* To extract files, use `x` for extract, `f` as using filename, `z` as we have zip file.

```bash
tar xfzv mytar.tar.gz
```
