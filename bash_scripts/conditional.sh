[[ 4 -gt 3 ]]
# Conditionals are always written in double square brackets
echo $?

number=7
[[ $number -gt 3 ]] && echo t || echo f
[[ $number -gt 10 ]] && echo t || echo f
[[ -e $number ]] && echo t || echo f

[[ 7 -gt 2 ]] && echo t || echo f # if true print t else print f
[[ ! 7 -gt 2 ]] && echo t || echo f
[[ 6 -ne 3 ]] && echo t || echo f


