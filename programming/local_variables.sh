#!/bin/bash
myvar=30
myfunc() {
  local myvar=10
  echo "Local myvar is $myvar"
}

myfunc
echo $myvar