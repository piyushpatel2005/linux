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

# iterate over options is finished
# iteration over parameters started.
num=1
for param in $@
do
  echo "#num: $param"
  num=$(( $num + 1 ))
done

# ./options2.sh -a -b -c -- p1 p2 p3