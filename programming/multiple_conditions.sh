#!/bin/bash
mydir=/home/pc
name="pc"
if [ -d $mydir ];then
  echo "$mydir exists"
fi
if [ -n $name ]; then
  echo "$name is non zero"
fi
if [ -d $mydir ] && [ -n $name ]; then
  echo "The name is not zero length and the directory exist."
else
  "One of the tests failed."
fi