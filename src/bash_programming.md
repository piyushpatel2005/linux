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

