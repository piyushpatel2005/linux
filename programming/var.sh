#!/bin/bash
name="Piyush"
# Dont declare like name = "Piyush" spaces are not allowed
age=35
total=16.5
echo $name
echo $age
echo $total

myarr=(one two three four five)
echo "\${myarr[1]}: ${myarr[1]}" # prints two
echo "\${myarr[*]}: ${myarr[*]}"
echo "Unsetting second element of the array using unset command"
unset myarr[1]
echo "${myarr[*]}"