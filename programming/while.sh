COUNT=10
while (( COUNT >= 0 )); do
  echo -e "$COUNT \c" # \c escape sequence allows the suppression of the line feed normally used with echo.
  (( COUNT-- ))
done; echo