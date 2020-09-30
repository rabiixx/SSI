#!/bin/bash

while IFS= read -r cypher
do
	echo "$cypher"
	while IFS= read -r password
	do
		str=$(echo "U2FsdGVkX1/gKHa6FAvvqqiMS91UjK5eWB7N65GUDj9a+dDuVSnyD7Z0GStU1nM+N6FgBjcD3g==" | openssl enc -base64 -d -a | openssl enc $cypher -d  -pass pass:$password 2>/dev/null)

		case "$str" in *"flag"*)
			echo "***FLAG encontrada***"
			echo "[+] Algoritmo de Cifrado: $cypher\n"
			echo "[+] Contraseña: $password\n"
			echo $str >> flag2.txt
			exit
			;;
		esac


#		if [[ $str == *"flag"* ]]; then
#		        echo "***FLAG encontrada***"
#			echo "[+] Algoritmo de Cifrado: $cypher\n"
#			echo "[+] Contraseña: $password\n"
#			echo $str >> flag.txt
#		fi

		#RET=$?
		#if [ $RET -eq 0 ]
		#then
		#	echo "Candidate password: $password" >> decrypted.txt
		#fi
	done < $2
done < $1
