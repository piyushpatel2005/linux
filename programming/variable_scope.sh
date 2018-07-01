#!/bin/bash
myvar=10
myfunc() {
  myvar=50 # It can access global scope
}
myfunc
echo $myvar