#!/bin/bash

ch="#"
prog=1

while true
do
	echo -ne $prog
	str=$(printf '%*s' "$prog" | tr ' ' "$ch")
	echo -ne "$str\r"
	sleep .5

	((prog++))
done
