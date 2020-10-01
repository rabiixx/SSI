#!/bin/bash

# Script Ttile: OpenSSL Brute-Force Decrypter
# Date: 09/30/2020
# Author: rabiixx
# Tested Version: OpenSSL 1.1.1g 21 Apr 2020
# Tested on: 5.7.0-kali1-amd64 (VM Virtual Box)

# Usage: sh decrypt.sh cypher_list wordlist
# Description: This program tests a list passwords (wordlist) againts a list of given cyphers in search of  *flag*.
# In case you want to seach for another substring, modify the *flag* subtring in case statement.
# When flag is found, the flag is written to flag.txt file. If the flag is not found, the flag.txt wont exist.

while IFS= read -r cypher
do
	echo "$cypher"
	while IFS= read -r password
	do
		str=$(echo "U2FsdGVkX1/gKHa6FAvvqqiMS91UjK5eWB7N65GUDj9a+dDuVSnyD7Z0GStU1nM+N6FgBjcD3g==" | openssl enc -base64 -d -a | openssl enc $cypher -d  -pass pass:$password 2>/dev/null)

		case "$str" in *"flag"*)
			echo "***FLAG encontrada***"
			echo "[+] Algoritmo de Cifrado: $cypher"
			echo "[+] Contraseña: $password"
			echo $str > flag.txt
			exit
			;;
		esac
	done < $2
done < $1
