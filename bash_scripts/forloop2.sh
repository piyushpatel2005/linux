echo "Explicit list:"

for picture in img001.jpg img002.jpg img451.jpg
do
	echo "Picture equal to $picture"
done

echo ""
echo "Array:"
stooges=(curly larry moe)

for stooge in ${stooges[*]}
do
	echo "Current stooge: $stooge"
done

echo ""
echo "Command substition:"

# get all files and iterate over them
for code in $(ls)
do
	echo "$code is a bash script"
done
