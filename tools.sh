#!/bin/bash

main(){

	while true; do
		echo "======================="
		echo "1: install nginx"
		echo "2: install tomcat"
		echo "3: install docker"
		
		read number
		echo "Your choice is ${number}."
		
		if [ ${number} == q ]; then
			exit 0
		fi
		
		if [ $number == 1 ]; then
			echo "install nginx."
		fi

		if [ $number = 2 ]; then
			echo "install tomcat"
		fi

	done
}

main
