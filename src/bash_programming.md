# Bash Programming

`expr` is used to evaluate expressions.

```bash
# Math in Bash
#!/usr/bin/env bash
expr 5 + 2
expr 5 - 2
expr 5 \* 2
expr 5 / 2
expr 5 % 2
```

[Maths with shell](../bash_scripts/bigmath.sh)

You can create variable using `animal=4`
To change the value use operator `let`

[Variables](../bash_scripts/variables.sh)

[Take user input](../bash_scripts/readvariables.sh)

```bash
let animal=5
echo $animal
```

Bash also supports conditionals like true and false. It also supports logical operators && and ||.

[Logical operations](../bash_scripts/logical_operations.sh)

When an operation succeeds, it returns a return code of 0 otherwise it will return any value other than 0.

[Conditionals](../bash_scripts/conditional.sh)
We can also pass command line arguments and access them in a shell script using $1, $2

[Commandline arguments](../bash_scripts/args.sh)

We can print all command line arguments using $@.
We can print number of arguments using $#.

The conditional expressions are written inside double square brackets

`[[ $number -gt 4 ]] # number greater than 4`


Here are logical expressions nad their meaning

| Logical Flag | Meaning | Usage |
|--------------:|--------:|------:|
| -gt | Greater than | [[ $plants -gt 8 ]] |
| -lt | Less than | [[ $votes -lt 3 ]] |
| -ge | Greater than or equal to | [[ $number -ge 3 ]] |
| -eq | Equal to | [[ $spaces -eq 4 ]] |
| -ne | Not equal to | [[ $pages -ne 0 ]] |
| -le | less than or equal to | [[ $candles -le 9 ]] |
| -e | A file exists | [[ -e $taxes ]] |
| -d | A directory exists | [[ -d $photos ]] |
| -z | Length of string is zero | [[ -z $name ]] |
| -n | Length of String is non zero | [[ -n $name ]] |


[Logical](../bash_scripts/logical.sh)

Similarly there are logical operations

| Logical operator | Meaning | Usage |
|------------------:|--------:|------:|
| =~ | Matches regular expression | [[ $consonants =~ [aeiou] ]] |
| = | string equal to | [[ $password = "pegasus" ]] |
| != | String not equal to | [[ $fruit != "banana" ]] |
| ! | not | [[ ! "apple" =~ ^b ]] |

## Conditionals

[If Else example](../bash_scripts/ifelse.sh)

[Nested if else](../bash_scripts/nestedif.sh)

[Conditional if](../bash_scripts/condif.sh)

## Arrays

Arrays can be defined like this:

```shell
names = (piyush ishit romin pritesh zamira hitixa) # array elements are space separated
echo ${names[0]}
echo ${names[3]} # print 4th name
echo ${names[*]} # print all names
names[5]=none
echo ${names[*]}
names+=(bhavik priyank)
echo ${names[*]}
echo ${names[*]:3:1} # one name from 4th element in the array
```

## Braces

It creates strings out of sequences and it is known as brace expansion. Brace expansion uses {..} syntax.

```shell
echo {0..9} # 0 1 2 3 4 5 6 7 8 9
echo {a..e}
echo a{1..2} # a1 a2
echo b{0..1}c # b0c b1c

echo {{1..3},{a..c}}
echo {Who, What, Why}?
```

[Braces script](../bash_scripts/braces.sh)

## Loops

[for loop](../bash_scripts/forloop.sh)

[For loop to iterate over all files](..bash_scripts/forloop2.sh)

[Nested for loop](../bash_scripts/nestedfor.sh)

With while loop make sure to avoid infinite loop
[While loop](../bash_scripts/while.sh)


## Functions

A function is a small piece of code that has a name.

```shell
function hello {
    echo "hello"
}
hello # call the new function
```

We can use the defined functions in command line using source command.

Check [this file](../bash_scripts/greet.sh)

This has a function named greet_user which can be used from command line as follows.

```shell
source greet.sh
greet piyush
```

[add sequence](../bash_scripts/addseq.sh)

```shell
source addseq.sh
addseq 12 90
addseq 1 2 3
```

When the function is run like this, it also retains the variables inside of that functions. For example even after executing the function, the variables $sum is still available and can be seen using command `echo $sum`.
This may override any other variable declared in a session.

```shell
function addseq2 {
    local sum=0 # local prevents this variable side effects
    for element in $@
    do
        let sum=sum+$element
    done
    echo $sum
}
```

```shell
ls -l | head -n 3
```

We can create different alias for some commands

For example,

```shell
nano ~/.bash_profile

alias docs='cd ~/Documents'
source ~/.bash_profile

# We can also create custom functions and run it. For example

source ~/Downloads/addseq.sh
source ~/.bash_profile
addseq 9 87
```

**Variables in Shell**

```shell
#!/bin/sh
echo "I was called with $# parameters"
echo "My name is $0"
echo "My first parameter is $1"
echo "My second parameter is $2"
echo "All parameters are $@"
echo "Last command exit status: $?"

while [ "$#" -gt "0" ]
do 
	echo "\$1 is $1"
	shift # shifts the value one by one
done
```


```shell
# var5.sh
# Get the exit value of the last command whether the last command was successful or not.
/usr/local/bin/my-command
# $? is used for this. If successful it will have 0 value or else something else
if [ "$?" -ne "0" ]; then
	echo "Sorry, we had a problem there!"
fi
echo "\$! is $!"  # $! contains the process identifier PID of the last run background process
echo "\$$ is $$" # $$ is the PID of currently running shell.
```

```shell
#!/bin/sh
# change internal field separator
# IFS is internal field separator
old_IFS="$IFS"
IFS=:
echo "Please, input some data separated by colons"
read x y z
IFS=$old_IFS
echo "x is $x, y is $y and z is $z"
```

```shell
while:
do
	echo "Please type something in (^C to quit):"
	read INPUT_STRING
	echo "You typed $INPUT_STRING"
done

# for loop
for i in hello 1 * 2 goodbye
do 
	echo "Looping ... i is set to $i"
done

# case statementsls
echo "Please talk to me..."
while:
do
	read INPUT_STRING
	case $INPUT_STRING in
		hello)
			echo "Hello there!"
			;;
		bye)
			echo "See you again!"
			break
			;;
		*)
			echo "Sorry, I don't understand"
			;;
	esac
done
```

**Testing if a command ran successfully**

```shell
if command; then
	echo "$command ran successfully now doing this.."
else
	echo "$command failed and now running that..."
fi
# $? can be used to test if the exit status is 0 or 1 (error)
```

## Getting user input

We can get user input using `read` command.

```shell
read -n "What is your name? " # omits the new line charater at the end 
echo $REPLY # we get value using REPLY variable by default
# If we want to populate particular variable by prompting user
read -p "What is your name? " name
echo $name
# To limit user input to single character use:
read -n1 -p "Press any key to exit"
# To hide the user input use -s flag, useful for password or PIN
read -sn1 -p "Press any key to exit"
```

We can pass different options using hyphen.

```shell
#!/bin/bash
while [ -n "$1" ]
do
    case "$1" in
        -a) echo "-a option used" ;;
        -b) echo "-b option used" ;;
        -c) echo "-c option used" ;;
        *) echo "Option $1 not an option" ;;
    esac
    shift # shifts the options one step to the left
done
```

We can pass options by separating them with double dash like `./script.sh -a -b -c -- p1 p2 p3`

```shell
#!/bin/bash
while [ -n "$1" ]
do
    case "$1" in
        -a) echo "-a option found" ;;
        -b) echo "-b option found" ;;
        -c) echo "-c option found" ;;
        --) shift
            break ;;
        *) echo "Option $1 not an option" ;;
    esac
    shift
done
# Iterate over parameter values
num=1
for param in $@
do
    echo "#$num: $param"
    num=$(( $num + 1 ))
done
```

To read option with its value along with it, we can use below code.

```shell
#!/bin/bash
while [ -n "$1" ]
do
    case "$1" in
        -a) echo "-a option passed" ;;
        -b) param="$2"
            echo "-b option passed, with value $param"
            shift ;;
        -c) echo "-c option passed" ;;
        --) shift
            break ;;
        *) echo "Option $1 not an option" ;;
    esac
    shift
done
num=1
for param in "$@"
do
    echo "#$num: $param"
    num=$(( $num + 1 ))
done
```

Reading a file

```shell
#!/bin/bash
while read line
do 
echo $line
done < yourfile.txt
```

Verify user input using `-z` flag with test command.

```shell
#!/bin/bash
echo "You are using $(basename $0)"
test -z $1 || echo "Hello $1"
exit 0
```

We can use test command to test multiple expressions.

```shell
test EXPRESSION -a EXPRESSION # AND
test EXPRESSION -o EXPRESSION # OR
[ EXPRESSION ] # shorthand for test EXPRESSION
test -n $SSH_TTY # test if a string has a value
test $# -gt 0 # test integer values
test number1 -eq number2 # test if number1 is equal to number2
```

`test` command has few flags totest various options.
- `-d`: shows if it's a directory
- `-e`: shows if file exists in any form
- `-x`: shows if file is executable
- `-f`: shows if file is a regular file
- `-r`: shows if file is readable
- `-p`: shows if file is a named pipe
- `-b`: shows if file is a block device
- `file1 -nt file2`: checks if file1 is newer than file2
- `file1 -ot file2`: checks if file1 is older than file2
- `-O file`: checks if logged-in user is the owner of the file
- `c`: shows if the file is a character device
- `if [ $string1 = $string2 ]`: checks if string1 is identical to string2
- `if [ $string1 != $string2 ]`: checks if string1 is not identical
- `if [ $string1 \< $string2 ]`: checks if string1 is less than string2
- `if [ -n $string1 ]`: checks if string1 is longer than zero
- `if [ -z $string1 ]`: checks if string1 has zero length

Combine multiple tests

```shell
#!/bin/bash
mydir=/home/mydir
name="piyush"
if [ -d $mydir ] && [ -n $name ]; then
	echo "The name is not zero length and the directory exists."
else
	echo "One of the tests failed."
fi
```

Backup script with different compression rates.

```shell
#!/bin/bash
# Author: First Last
read -p "Choose H, M or L compression " file_compression
read -p "Which directory do you want to backup to " dir_name
# Create directory if doesn't exist
test -d $HOME/$dir_name || mkdir -m 700 $HOME/$dir_name
backup_dir=$HOME/$dir_name
tar_l="-cvf $backup_dir/b.tar --exclude $backup_dir $HOME"
tar_m="-czvf $backup_dir/b.tar.gz --exclude $backup_dir $HOME"
tar_h="cjvf $backup_dir/b.tar.bzip2 --exclude $backup_dir $HOME"
if [ $file_compression = "L" ]; then
	tar_opt=$tar_l
elif [ $file_compression = "M" ]; then
	tar_opt=$tar_m
else
	tar_opt=tar_h
fi
tar $tar_opt
exit 0
```

using case statements

```shell
#!/bin/bash
# search.sh
usage: "Usage: search.sh file string operation"

if [ ! $# -eq 3 ] ; then 
    echo "$usage"
    exit 2
fi

[ ! -f $1 ] && exit 3

case $3 in
    [cC])
        mesg="Counting the matches in $1 of $2"
        opt="-c"
        ;;
    [pP])
        mesg="Print the matches of $2 in $1"
        opt=""
        ;;
    [dD])
        mesg="Printing all lines but those matching $3 from $1"
        opt="-v"
        ;;
    *)
        echo "Could not evaluate $1 $2 $3";;

esac
echo $mesg
grep $opt $2 $1
```

`test -f /etc/hosts -a -r /etc/hosts` tests whether a file exists and if exists it is readable.

### Loops:

```shell
#!/bin/bash
echo "uyou are using $(basename $0)"
for n in $*
do
    echo "Hello $n"
done
exit 0
```

```shell
#!/bin/bash
file="file1.txt"
IFS=$'\n' # changed default IFS of space to new line
for var in $(cat $file)
do
    echo $var
done
```

Check whether the path is a directory or a file.

```shell
#!/bin/bash
for path in /home/username/*
do
    if [ -d "$path" ]
    then
        echo "$path is a directory"
    elif [ -f "$path" ]
    then
        echo "$path is a file"
    fi
done
```

```shell
#!/bin/bash
for (( v1 = 1; v1 <= 3; v1++ ))
do
    echo "First loop $v1:"
    for (( v2 = 1; v2 <= 3; v2++ ))
    do
        echo "  Second loop: $v2"
    done
done
```

We can redirect output of the loop.

```shell
#!/bin/bash
for (( v1 = 1; v1 <= 5; v1++ ))
do
    echo "$v1"
done > file
```

We can use `continue` and `break` for controlling execution of the loop.

```shell
#!/bin/bash
for f in *
do
    [ -d "$f" ] || continue
    dir_name="$dir_name $f"
done
echo "$dir_name"
```

**While loop** can be created as below.

```shell
#!/bin/bash
COUNT=10
while (( COUNT >= 0 ))
do
    echo -e "$COUNT \c"
    (( COUNT-- ))
done; echo
```

```shell
#!/bin/bash
while read server
do
    ping -c1 "$server" && servers_up="$servers_up $servers"
done < servers.txt
```

```shell
#!/bin/bash
# Author: First Last
# Sample menu
# Last Edited: April 2020
while true
do
    clear
    echo "Choose an item: a, b or c"
    echo "a: Backup"
    echo "b: Display calendar"
    echo "c: Exit"
    read -sn1
    case "$REPLY" in
        a) tar -czvf $HOME/backup.tgz $HOME/bin ;;
        b) cal ;;
        c) exit 0 ;;
    esac
    read -n1 -p "Press any key to continue"
done
```

### Functions

To display the functions residing in shell environment, use `declare -F`. Using `-f` option, you can display function and associated definition.  To see single function, we can use `type <function_name>`.

```shell
#!/bin/bash
is_file() {
    if [ ! -f "$1" ] ; then
        echo "41 does not seem to be a file"
    fi
}

clean_file() {
    is_file "$1"
    BEFORE=$(wc -l "$1")
    echo "The file $1 starts with $BEFORE"
    sed -i.back '/^\s#/d;/^$/d' "$1"
    AFTER=$(wc -l "$1")
    echo "The file $1 is now $AFTER"
}

read -p "Enter a file to clean: "
clean_file "$REPLY"
exit 1
```

```shell
#!/bin/bash
myfunc() {
    arr=$@
    echo "The array from inside the function: ${arr[*]}"
}
test_arr=(1 2 3)
echo "The original array is: ${test_arr[*]}"
myfunc ${test_arr[*]}
```

By default, variables declared inside a function is a global variable. If you want to declare a variable that is exclusive to the function, you can create local variable as `local myvar=0`. We can return values from function using `return` statement.

```shell
#!/bin/bash
to_lower() {
    input="$1"
    output=$( echo $input | tr [A-Z] [a-z])
    return $output
}

while true
do
    read -p "Enter c to continue or q to exit: "
    $REPLY=$(to_lower "$REPLY")
    if [ $REPLY = "q" ]; then
        break
    fi
done
echo "Finished"
```

The `sed` command is stream editro and opens the file line by line to search or edit the file content.

```shell
#!/bin/bash
read -p "Enter a username: "
if (grep "$REPLY" /etc/passwd > /dev/null) ; then
    echo "The user $REPLY exists"
    exit 1
fi
```

With `grep` we can use different options like `-i` for case insensitive search, `-c` for counting occurrences of particular string, `-v` for reverse string (to find everything but a string).

```shell
#!/bin/bash
CPU_CORES=$(grep -c name /proc/cpuinfo)
if (( CPU_CORES < 4 )) ; then
    echo "A minimum of 4 cores are required"
    exit 1
fi
```

Parsing CSV is easy with while loop with column names. For example, below script parses product, price and quantity data from CSV file.

```shell
#!/bin/bash
OLDIFS="$IFS"
IFS=","
while read product price quantity
do
    echo -e "\33[1,33m$product \
    ===============================\033[0m\n\
    Price : \t $price \n\
    Quantity: \t $quantity \n"
done < "$1"
IFS="OLDIFS"
```

`sed` with `p` operator will print the matched pattern.

- p: Print the original content
- g: Global replacement for all occurrences
- w: Filename: send results to a file

```shell
sed 'p' /etc/passwd # print all lines
sed -n 'p' /etc/passwd # suppress STDOUT
sed -n '/^root/ p' /etc/passwd # print line starting with root
sed s/pattern/replacement/flags
sed -n ' /^pi/ s/bash/sh/p ' /etc/passwd # replace the default shell of the user pi
sed 's/sed/Linux sed/g' myfile # replace 'sed' word with 'Linux sed' word globally.
sed 's/sed/Linux sed/w outputfile' myfile # send results to new outputfile file.
sed 's/sed/Linux sed/2' myfile # replace only 2 occurrences
sed '2s/old text/new text/' myfile # replace only second line of the file
sed '3,5s/old text/new text/' myfile # replace third to fifth lines
sed '2,$s/old text/new text/' myfile # replace from second line to end of file
```

The `-i` option is used run an in-place update. We will not need the `-n` or `p` command when editing the file. The insert `i` and append `a` commands insert specified text before the specified line or pattern and after the specified line or pattern respectively. The change command `c` is used for changing the entire line. The transform command `y` works very much like `tr` unix command and it applies to entire stream.

We can apply multiple sed commands using `-e` option and separating the commands with a semicolon.

```shell
# there will not be any output but the file will reflect the changes
# to pattern match we can use place holder '@' to match the pattern. It is similar to
# sed -i '/^pi/ s\/bin\/bash/\/bin\/sh/' $HOME/passwd
sed -i '/^pi/ s@/bin/bash@/bin/sh/' $HOME/passwd
# Create a backup file before making the change by appending a string directly after the -i option and without any spaces.
sed -i.bak '/^pi/ s@/bin/bash@/bin/sh/' $HOME/passwd
# Delete range of lines using 'd' command to delete
sed '3d' myfile # delete the third line
# Delete third to fifth line from stream
sed '3,5d' myfile
# Delete from fourth line to end of the file
sed '4,$d' myfile
# Deletion happens only to the stream. To actually delete from file, you can use -i option.
sed -i '2d' myfile # permanently delete the second line from the file
sed '2i\inserted text' myfile # insert a line as second line
sed '2a\inserted text' myfile # insert a line as third line
sed '2c\modified the second line' myfile # modifies the second line with given text
sed 'y/abc/ABC/' myfile # replace text 'abc' with 'ABC'
sed -e 's/First/XFirst/; s/Second/XSecond/' myfile
```

### AWK 

The `awk` command is a command suite in UNIX and Linux. It allowws access to AWK programming language designed to process data within text streams.

```shell
awk 'BEGIN { print "Hello World!" }'
# Print all the lines from a file
awk '{ print }' /etc/passwd
# $0 for entire line, $1 for first field, $2 second field, $3 third field and so on
awk '{ print $0 }' /etc/passwd
awk -F":" '{ print $1 }' /etc/passwd # change field separator to colon
awk 'BEGIN { FS=":" } { print $1 }' /etc/passwd # first block is executed once, second is processed for each line
# awk internal variable NR maintains
awk 'BEGIN { FS=":" }{ print $1} END { print NR }' /etc/passwd # include total number of lines
# We can also write expressions in quotes into multiple lines
awk 'BEGIN { FS=":" }
{ PRINT $1 }
END { print "Total: ", NR}' /etc/passwd
# Display line number while processing
awk 'BEGIN { FS=":" } { print NR, $1 } END { print "Total: ", NR }' /etc/passwd
# Emulate wc -l command in awk
awk 'END { print NR }' /etc/passwd
# print first 5 lines only
awk ' NR < 6' /etc/passwd
# print lines 8 thorugh to 12
awk 'NR==8,NR==12' /etc/passwd
# print lines ending in bash
awk '/bash$/' /etc/passwd
```

There are many built-in variables in AWK.

- FIELDWIDTHS: specifies the field width
- RS: record separator
- FS: specifies field separator
- OFS: output separator, which is space by default
- ORS: output separator
- FILENAME: holds the processed file name
- NF: holds the line being processed
- FNR: holds the record which is processed
- IGNORECASE: Ignores character case

If we have a file like below. Each record is separated by an empty line and the fields are separated by newline

```
John Doe
15 Doe Street
(123) 456-7890

Ahmed Hussain
10 Music St
(354) 234-2342
```

```shell
# John Doe (123) 456-7890
awk 'BEGIN{FS="\n";RS=""} {print $1,$3}' myfile
# Joh Doe*(123) 456-7890
awk 'BEGIN{FS="\n";RS="";OFS="*"}{print $1,$3}' myfile
```

We can define variables using any text other than numbers. We can also use conditional statements like `if..else` along with loops.

```shell
awk 'BEGIN{ var1=2;var2=3;var3=var1+var2; print var3}'
awk 'BEGIN{str1="Welcome ";str2="To shell scripting";str3=str1 str2;print str3}'
# print only first column where value is greater than 50
awk '{if ($1 > 50) print $1}' myfile
awk '{
    if ($1 > 50) { x = $1 * 2; print x }
    else { x = $1 * 3; print x}
}' myfile
# find mean on each line from 3x3 matrix
awk '{
    total = 0
    i = 1
    while (i < 4) {
        total += $i
        i++
    }
    mean = total / 3
    print "Mean value: ", mean
}' myfile
# for loop
awk '{
    total = 0
    for (var = 1; var < 4; var++) {
        total += $var
    }
    mean = total / 3
    print "Mean value: ", mean
}' myfile
# Make comma separated values file
awk 'BEGIN {FS=":"} { print $1,$3,$7 }' /etc/passwd
awk 'BEGIN { FS=":" }
    { printf "%10s %4d %17s\n", $1,$3,$7 }' /etc/passwd
awk 'BEGIN { FS=":"; printf "%10s %4s %17s\n", "Name", "UID", "Shell" }
    { printf "%10s %4d %17s\n", $1,$3,$7 }' /etc/passwd
awk 'BEGIN{x=sqrt(5); print x}'
awk 'BEGIN{ x = "welcome"; print toupper(x) }'
```

**Regular expressions** are strings that the regex engine interprets to match a specific text.
- the caret (^) matches the beginning of the line
- dollar sign ($) matches end of the text
- exclamation mark (!) means negation character.
- dot (.) character matches any character except the new line (\n)
- The character class is specified using [] square brackets and it is negated by caret(^) symbol. So, `[^br]ash` matches anything but bash or rash.
- `[a-d]` specifies range of characters from a to d.
- asterisk (*) is used to match the existence of a character or a character class zero or more times.
- The question mark (?) matches existence of preceding character or character class zero or one time only.
- The plus (+) sign matches the existence of the preceding character or character class one time or more, so it must exist at least once.
- The curly braces define the number of existence of the preceding character or character class
- The pipe character (|) tells regex engine to match any of the passed strings. It is like logical OR
- Expressions can be grouped using parentheses () to make them one piece

```shell
echo "Welcome to shell scripting" | awk '/shell/{print $0}'
echo "Welcome to shell scripting" | sed -n '/shell/p'
echo "Welcome to shell scripting" | awk '/^Welcome/{print $0}'
echo "Welcome to shell scripting" | sed -n '/scripting$/p'
awk '/.sh/{print $0}' myfile # matches all lines with 'sh' string
sed -n '/[mbr]ash/p' myfile # matches lines with bash, mash or rash word in it
echo "welcome to shell scripting" | awk '/^[Ww]elcome/{print $0}'
awk '/[^br]ash/{print $0}' myfile
awk '/[a-m]ash/{print $0}' myfile
awk '/[d-hm-z]ash/{print $0}' myfile # matches d-h and m-z range of characters
```

Special character classes include regex for extended regular expressions.

- `[[:alpha:]]`: matches any alphabetic character
- `[[:upper:]]`: matches A-Z uppercase only
- `[[:lower:]]`: matches a-z lowercase only
- `[[:alnum:]]`: matches 0-9, a-z, A-Z
- `[[:blank:]]`: matches space or tab only
- `[[:space:]]`: matches any whitespace character: space, tab, CR
- `[[:digit:]]`: matches from 0 to 9
- `[[:punct:]]`: matches any punctuation character

```shell
awk '/[[:upper:]]/{print $0}' myfile
echo "Checking colours" | awk '/colou*rs/{print $0}'
sed -n '/this.*/p' myfile
echo "toot" | awk '/t[aeor]*t/{print $0}' # matches
echo "tent" | awk '/t[aeor]*t/{print $0}' # doesn't match due to 'n'
echo "tot" | sed -r -n '/to?t/p' # matches
echo "toot" | sed -r -n '/to?t/p' # doesn't match
echo "toot" | sed -r -n '/t[oa]?t/p'
echo "tot" | sed -r -n '/to+t/p' # matches
echo "tt" | sed -r -n '/to+t/p' # doesn't match
echo "toot" | awk '/to{1,2}t/{print $0}' # matches
echo "toot" | awk '/t[oa]{1}t/{print $0}' # doesn't match
echo "welcome to shell scripting" | awk '/Linux|bash|shell/{print $0}' # matches shell
echo "welcome to shell scripting" | awk '/(bash scripting)?/{print $0}' # matches zero or more times
echo "welcome to shell scripting" | awk '/(bash scripting)+/{print $0}' # doesn't match
```

