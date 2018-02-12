chapter_number=5
let chapter_number=$chapter_number+1  # to modify a variable use let operator
echo $chapter_number # to print variable data use $ before variable name
let chapter_number=chapter_number+1
echo $chapter_number
# let chapter_number=chapter_number + 1 # throws error
echo chapter_number # this will print chapter_number and not the data
# spaces are not allowed around = sign
the_empire_state="New York"
echo $the_empire_state
# we can run other terminal commands when we put them in $()
math_lines=$(cat bigmath.sh | wc -l)
echo $math_lines

echo "I went to school in $the_empire_state."

