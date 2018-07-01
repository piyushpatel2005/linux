#!/bin/bash
file="file.txt"
IFS=$'\n' # Here we change the default IFS to be a newline
for line in $(cat $file)
do
  echo "$line"
done