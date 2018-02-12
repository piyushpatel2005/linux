echo "Start program"

if [[ $1 -eq 4 ]] 
then 
	echo "You entered $1"
elif [[ $1 -gt 3 ]] 
then
	echo "The argument is greater than 3"
else
	echo "This will run if statement if you pass 4 as command line argument"

fi
echo "End program"

