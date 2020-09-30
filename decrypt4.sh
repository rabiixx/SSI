#!/bin/bash

while IFS= read -r cypher
do
	echo "$cypher"
	while IFS= read -r password
	do
		str=$( openssl enc $cypher -d -in encrypted_b64.enc -pass pass:$password 2>&1)

		#echo $str;
#		if [[ $str == *"flag"* ]]; then
#		        echo "***FLAG encontrada***"
#			echo "[+] Algoritmo de Cifrado: $cypher\n"
#			echo "[+] Contraseña: $password\n"
#			echo $str >> flag.txt
#		fi

		case "$str" in *flag*)
			echo "***FLAG encontrada***"
			echo "[+] Algoritmo de Cifrado: $cypher\n"
			echo "[+] Contraseña: $password\n"
			echo $str >> flag.txt
    			;;
		esac

		#RET=$?
		#if [ $RET -eq 0 ]
		#then
		#	echo "Candidate password: $password" >> decrypted.txt
		#fi
	done < $2
done < $1
