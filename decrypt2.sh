#!/bin/bash

while IFS= read -r cypher
do
	echo "$cypher"
	echo "U2FsdGVkX1/gKHa6FAvvqqiMS91UjK5eWB7N65GUDj9a+dDuVSnyD7Z0GStU1nM+N6FgBjcD3g==" | openssl enc -base64 -d | openssl enc $cypher -d -pass pass:soccer10 -out /dev/null
done < $1
