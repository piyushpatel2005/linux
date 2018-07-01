#!/bin/bash
for path in /home/pc/*
do
  if [ -d "$path" ]
  then
    echo "$path is a directory"
  elif [ -f "$path" ] # files could contain spaces that's why we should use double quotes
  then
    echo "$path is a file"
  fi
done