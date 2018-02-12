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


[Logical](../bash_scripts/logical_operations.sh)

Similarly there are logical operations

| Logical operator | Meaning | Usage |
|------------------:|--------:|------:|
| =~ | Matches regular expression | [[ $consonants =~ [aeiou] ]] |
| = | string equal to | [[ $password = "pegasus" ]] |
| != | String not equal to | [[ $fruit != "banana" ]] |
| ! | not | [[ ! "apple" =~ ^b ]] |

[If Else example](../bash_scripts/ifelse.sh)

[Nested if else](../bash_scripts/nestedif.sh)

[Conditional if](../bash_scripts/condif.sh)


