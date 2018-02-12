this_command_does_not_exist # this throws error
echo $? # this throws the exit status code

echo I will succeed
echo $? # this throws 0 status code for success

# The same kind of status codes exist for true and false
# true has status code of 0
# Based on these status codes it will decide further action
# Bash supports logical operations like && and ||
true
echo "Status code after true $?"

false 
echo "Status code after false $?"

echo "false && true && echo Hello"
false && true && echo Hello # one status success status code will take it to next action
echo "1 && false && echo 3"
echo 1 && false && echo 3

false || echo 1 || echo 2
echo 3 || false || echo 4
echo Athos || echo Porthos || echo Aramis

echo "[[ 4 -gt 3]] && echo t || echo f"
echo [[ 4 -gt 3]] && echo t || echo f

