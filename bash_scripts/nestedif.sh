if [[ $1 -gt 3 ]] && [[ $1 -lt 7 ]]
then
	if [[ $1 -eq 4 ]]
	then
		echo "four"
	elif [[ $1 -eq 5 ]]
	then
		echo "five"
	else
		echo "six"
	fi
else
	echo "You entered $1"
fi
