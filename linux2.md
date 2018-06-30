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
| $* | Refers to all arguments |

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
