#!/bin/bash
mydir=/home/pc
if [ -d $mydir ]
then
  echo "Directory $mydir exists."
else
  echo "Directory $mydir doesn't exist."
fi