#!/bin/bash
read -p "Enter a user name: "
if (grep "$REPLY" /etc/passwd > /dev/null); then # redirect the result to null device
  echo "The user $REPLY exists"
  exit 1
fi
