# File System

- List files in the current folder

```bash 
ls
```

It would display different types of files and folders using different colors.

- List all files
```bash
ls -a
```

Dot files starting with (.) are considered system level files. They will not show up with simple `ls` command. They are usually configuration file.

- Long listing for all files

```bash
ls -la
```

- Get help for ls
```bash
ls --help
```

- To create new file:
```bash
touch <filename_with_extension>
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

- To change permissions, we can use:
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
chmod o-w test.txt
```

- Print working directory

```bash
pwd
```

- Copy a file

```bash
cp <filename> <new-location>
```

Example:

```bash
cp test.txt ~/Downloads
```

- Check the file in Downloads folder:

```bash
ls -la ~/Downloads/
```

- Remove file

```bash
rm <filename>
```

**Note:** `rm` removes the file permanently. It doesn't go to Recycle bin. If you want to be sure, you can use `rm -i filename` which will prompt again before deleting.


```bash
rm ~/Downloads/test.txt
ls -la ~/Downloads/test.txt
```

- Move files

```bash
mv <filename> <location>
```

- Rename file

```bash
mv <filename> <new-filename>
```

```bash
mv test.txt test2.txt
```

## Path Variables

- Look up path variables, where system will look for programs or executables.

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

-Edit a file:

```bash
echo this is my file > test.txt
```

'>' is output redirection. Here redirecting the text to test.txt file.

- Concatenate files

```bash
cat <filename> <filename2> ...
```

**Nano** is a file editor for Linux.

- Open a file with Nano

```bash
nano <filename>
```

- Open file in vi Editor:
```bash
vi <filename>
```




