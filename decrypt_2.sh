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



clear

if [ "$#" -eq 4 ]; then

	if [ $1 == -f ]; then

		echo "[+] $(file $2)"
		echo "[+] Number of Cyphers: $(wc -l $3)"
		echo "[+] Number of passwords: $(wc -l $4)"

		#tmpfile=$(mktemp)
		#tr -d '\n' < $2 > ${tmpfile}
		#cat ${tmpfile} > $2
		#rm -f ${tmpfile}

		while IFS= read -r cypher
		do
			echo "$cypher"
			while IFS= read -r password
			do
				str=$( openssl enc -base64 -d -in $2 | openssl enc $cypher -d -pass pass:$password 2>/dev/null | tr -d '\0')

				case "$str" in *"flag"*)
					echo "***FLAG encontrada***"
					echo "[+] Algoritmo de Cifrado: $cypher"
					echo "[+] Contraseña: $password"
					echo $str > flag.txt
					exit
					;;
				esac
			done < $4
		done < $3
	elif [ "$1" == "-s" ]; then

		numPass=$(wc -l $4 | awk '{print $1}')


		echo -n "[##################################################]"

		echo "Num pass: $numPass"
		echo "Encoded message: $2"
		echo "[+] Number of Cyphers: $(wc -l $3)"
		echo "[+] Number of passwords: $(wc -l $4)"

		while IFS= read -r cypher
		do
			echo "$cypher"
			i=1
			while IFS= read -r password
			do

				progression=$(($i*50))
				progression=$((progression/numPass))
				((progression++))
				echo $progression
				((i++))

				s=$(printf "%0.s#" $(seq 1 $progression))
				echo -ne "\r$s\r"
				
				str=$(echo "$2" | openssl enc -base64 -d | openssl enc $cypher -d -pass pass:$password 2>/dev/null| tr -d '\0')	

				case "$str" in *"flag"*)
					echo "***FLAG encontrada***"
					echo "[+] Algoritmo de Cifrado: $cypher"
					echo "[+] Contraseña: $password"
					echo $str > flag.txt
					exit
					;;
				esac
			done < $4
		done < $3
	else
		echo "Unrecognized option: $1"
		echo "Usage: sh decypt.sh [OPTIONS] cypher_list wordlist"
	fi


else
	echo "Usage: sh decypt.sh [OPTIONS] cypher_list wordlist"
fi


