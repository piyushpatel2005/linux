if [[ $1 -gt 3 ]] && [[ $1 -lt 7 ]]
then
	echo "$1 is between 3 and 7"
elif [[ $1 =~ "Piyush" ]] || [[ $1 =~ "Zamira" ]]
then
	echo "$1 works in the Data science team"
else
	echo "You entered $1, not what I expected"
fi

