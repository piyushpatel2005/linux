#!/bin/bash
echo "You are using $(basename $0)"
for n in $*
do
  echo "Hello $n"
done
exit 0

# bash for.sh piyush ishit pritesh romin