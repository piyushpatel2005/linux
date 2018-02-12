for number in {1..15}
do
	if [[ $number -lt 3 ]] || [[ $number -gt 8 ]]
	then
		echo $number
	fi
done

echo "Let's check even numbers"
for num in {1..10}
do
	val=expr $num % 2
	echo $val
	if [[ expr $num % 2=0 ]]
	then
		echo $num
	fi
done

