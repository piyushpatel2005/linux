#!/bin/bash
# Usage: search_script.sh <filename> <string_to_search> opeartion
usage="Usage: search_script.sh <filename> <string_to_search> operation"
if [ ! $# -eq 3 ] ; then
  echo "$usage"
  exit 2
fi

[ ! -f $1 ] && exit 3 # if file does not exist, exit with error code

case $3 in
  [cC])
    mesg="Counting the matches in $1 of $2"
    opt="-c"
  ;;
  [pP])
    mesg="Print the matches of $2 in $1"
    opt=""
  ;;
  [dD])
    mesg="Printing all lines but those matching $3 from $1"
    opt="-v" # invert operation, select not matching lines
  ;;
  *)
    echo "Could not evaluate $1 $2 $3"
  ;;
esac
echo $mesg
grep $opt $2 $1 # search with option in string in filename