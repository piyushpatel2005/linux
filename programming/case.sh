#!/bin/bash
if [ ! $# -eq 2 ] ; then
  echo "You must provide <student> <grade>"
  exit 2
fi
# $2 is grade, so we capitalize it using ^^ operator, so that it can be tested.
case ${2^^} in # Parameter expansion to capitalize input
  [A-C]) 
    echo "$1 is a star pupil"
  ;;
  [D])
    echo "$1 needs to try a little harder!"
  ;;
  [E-F])
    echo "$1 could do a lot better next year"
  ;;
  *)
    echo "Grade could not be found for $1 $2"
  ;;
esac

# Run as ./case.sh Piyush a
# ./case.sh Piyush unknown