# Mastering Linux Shell Scripting

```shell
sudo apt-get install bashdb
type ls # shows the type of ls command
type -a ls
type ls quote pwd do id

# include a directory into PATH variable
export PATH=$PATH:. # add current directory to PATH variable.
test -d $HOME/bin || mkdir $HOME/bin # check if directory exists, if not create one
```

**Update vim configuration**

```shell
vi $HOME/.vimrc
set showmode
set nohlsearch
set autoindent
set tabstop=4
set expandtab
syntax on
```

[Simple echo commad](programming/hello1.sh)

`exit 0` will ensure that the exit code is 0 which is success.

```shell
chmod +x ./programming/hello1.sh
./hello1.sh
echo $? # get the status of last command execution
```

| Argument Identifier | Description |
|:---------------------:|:--------------:|
| $0 | The name of the script itself which is often used in usage statements |
| $1 | A positional argument which is the first argument passed to the script |
| $# | The number of arguments |
| $* | Refers to all arguments in single string |
| $@ | Refers to all arguments, similar to $* but elements are in an array |

[Test above arguments](programming/hello2.sh)

[Variable Declarations](programming/var.sh)

All environment variables are written as uppercase letters. We can print environment variables using `printenv HOME` command.

Once the variable has been declared, it will be available for use in the entire bash script without any problems. To use the variable declared in one script into another script, export that variable as `export name`. Now it will be available in another script too!

Command substitution allows to store the output of running a command. For this we use back tick(`).

[Command substitution](programming/substitution.sh)

We can debug bash script using `bash -v script.sh`. This will print single statement and its output in next line.
`which echo` will show the echo command location.

`echo -n "Hello! May I ask your name?"` allows to escape new line for each echo statement.

[Example to use flags](programming/hello3.sh)

We use `read` command to read data from user.

`read -p <prompt> <variable_name>`

[Passing optional parameters](programming/options.sh)

[Getting option parameter values](programming/options3.sh)

There is a built-in option for getting options from the users, which is using the `getopt` function. Unfortunately, `getopt` doesn't support options with more than one character.

There are commonly used options.

* -a: List all items
* -c: Get a count of all items
* -d: Output directory
* -e: Expand items
* -f: Specify a file
* -h: Show the help page
* -i: Ignore the character case
* -l: List a text
* -o: Send output to a file
* -q: Keep silent; don't ask the user
* -r: Process something recursively
* -s: Use stealth mode
* -v: Use verbose mode
* -x: Specify an executable
* -y: Accept without prompting me

[Create backup files](programming/backup.sh)

[Pinging server](programming/ping.sh)

[Connect to SSH server](programming/connect_server.sh)

[Run MySQL](programming/run_mysql.sh)

[Read files](programming/read_file.sh)

## Decisions in Scripting

Decisions can be routed using && and || operators. The last command execution output can be found in `$?` system variable.

`who | grep 'pi' > /dev/null 2>&1 && write pi < message.txt`. Here `/dev/null` is a null location where anything can be redirected and it will be dicarded. Here we are redirecting error as well as stdout.

We can use shell builtin `test` to test different expressions. 

```shell
test EXPRESSION
test ! EXPRESSION # invert the test condition
test EXPRESSION1 -a EXPRESSION2 # EXPRESSION1 AND EXPRESSION2
test EXPRESSION1 -o EXPRESSION2 # EXPRESSION1 OR EXPRESSION2
[ EXPRESSION ] # short hand way to test
test $USER = root
[ $USER = root ]
test ! $USER = root
[ ! $USER = root ]
test -n $SSH_TTY # check if string has a value
[ -n $SSH_TTY ]
test -z $1 # test if string value is zero
[ -z $1 ]
test $# -gt 0 # number of arguments greater than zero
[ $# -gt 0 ]
```

eq, lt, gt, etc. operators work on integers only otherwise use the following operators.

[If Conditional](programming/if.sh)

For checking string, we can use different operators. In case we have string with spaces, we must use quotes around it.

```shell
if [ $string1 = $string2 ]
if [ $string1 != $string2 ]
if [ $string1 \< $string2 ]
if [ $string1 \> $string2 ]
if [ -n $string ] # if string is longer than zero
if [ -z $string ] # if string has zero length
```

[Relational operator](programming/relational.sh)

[Checking files and directories](programming/checking_files.sh)

Checking numbers is easy with relational operators gt, lt, etc.

[Relational operators with numbers](progrmaming/relational2.sh)

We can also test multiple conditions with && and || operations.

[Checking multiple conditions](programming/multiple_conditions.sh)

There is also else if conditional which uses structure like:

```shell
if <condition>; then
  statements;
elif <condition2>; then
  statement
else
  statement
fi
exit 0
```

Create backup script with option to select the compression level

[Backup files by specifying compression](programming/backup2.sh)

Sometimes, using multiple if statements is not convenient, so shell provides case statements as well. Basic layout is like this.

```shell
<case expression> in
  case1)
    statement1
    statement2
  ;;
  case2)
    ... ...
  ;;
  *)
    ... ...
  ;;
esac
```

[Case example](programming/case.sh)

We can create a search script using `grep` command to go through text and search required text.

[Search script](programming/search_script.sh)

## Vim Instructions

:x - Write and quit
vi filename - open the file
:wq! - write and close
:q! - close the file
:r filename = read given file in the opened editor


### Create snippets for VS Code

File | Preferences | User Snippets
Then type Shell
This opens `shellscript.json` file.

```json
// sample file
{
	// Place your snippets for shellscript here. Each snippet is defined under a snippet name and has a prefix, body and 
	// description. The prefix is what is used to trigger the snippet and the body will be expanded and inserted. Possible variables are:
	// $1, $2 for tab stops, $0 for the final cursor position, and ${1:label}, ${2:another} for placeholders. Placeholders with the 
	// same ids are connected.
	// Example:
	// "Print to console": {
	// 	"prefix": "log",
	// 	"body": [
	// 		"console.log('$1');",
	// 		"$2"
	// 	],
	// 	"description": "Log output to console"
	// }
	"Print a welcome message": {
		"prefix":"welcome",
		"body": [
      "echo 'Welcome to shell scripting!'"
      "echo 'This is second message'"
		],
		"description": "Print welcome message"
	}
}
```

Now open a new file and type `welcome`. you will see prompt so just press Enter key. It will populate the code you have in your script.

We can also bring color to the terminal for error and message etc.

## Test conditions

We can use `test` command to test different scenarios. For example, to test if `/etc/hosts` file exists, we can use 
`test -e /etc/hosts`
We can also check if regular file exists with given name.
`test -f /etc/hosts`

If we want to open a file from script, first test file is regular file, then test read permission. We can add *-a* option to AND multiple conditions. Then use *-r* condition to check that the file is readable.
`test -f /etc/hosts -a -r /etc/hosts`

Similarly, *-o* to OR a condition.
As an alternative to `test` command, we can implement the same conditional tests using single square bracket.
`[ -f /etc/hosts -a -r /etc/hosts ]`

In fact, `[` is actually a command. Type `test [`
`[ -f $FILE -a -r $FILE ] && cat $FILE`

We can use this file to redirect the localhost to better name similar to websites.

The use `[[` allows us to do more advanced condition testing but it is not available in Bourne shell. `[[` can solve some of the issues associated with white space in single square bracket command. We can include && and || instead of *-a* and *-o* options. It also allows pattern matching and regular expressions.
`[[ $FILE = *.pl ]] && cp"$FILE" scripts/`

`[[ $FILE =~ \.pl$ ]] && cp "$FILE" scripts/`

`if [[ $REPLY =~ colou?r ]] ; then`

We can also disable case sensitivity allowing COLOR and color by setting a shell option.

`shopt -s nocasematch`.
This option can be disabled using `shopt -u nocasematch`

With `((`, we can use even advanced features. We can do mathematical calculations inside this.
`a=(( 2 + 3 ))`

```shell
COUNT=1
(( COUNT++ ))
echo $COUNT

# standard  arithmetic tests
$(( COUNT > 1 )) && echo "Count is greater than 1"
```

## Providing default parameters

The shell options can be read with `$-` command.
`echo "My shell is $0 and the shell options are $-`
The options are as follows:
h: short for hashall. allows for programs to be found using PATH parameter
i: interactive shell
m: short for monitor. allows the use of bg and fg commands to bring commands in and out of the background
B: allows the brace expansion. mkdirdir{1,2} will create dir1 and dir2
H: allows history expansion of running commands and repeat commands from history

We can define default values as show in [Default value](programming/hello4.sh)

## Loops

```shell
type for

for u in bob joe
do
  useradd $u
  echo '$u:Password1' | chpasswd # pipe the created user to chpasswd
  passwd -e $u
done
```

[for loop](programming/for.sh)

[Iterate over lines of file](programming/iterate_file.sh)

[File and directories](programming/files_directories.sh)

[C style loop](programming/for2.sh)

[Nested loops](programming/nested_for.sh)

In shell scripting also, we have `break` and `continue` statements to control loop flow.

```shell
for f in * ; do
  [ -d "$f" ] || continue
  chmod 3777 "$f"
done
```

[While loop](programming/while.sh)