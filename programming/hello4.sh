#!/bin/bash
# name=$1
name=${1-"Anony"} # parameter substiution to define default values
[ -z $name ] && name="Anonymous"
echo "Hello $name"
exit 0