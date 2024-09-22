#!/bin/bash

/*
 Install application of operations engineer
*/

main(){

	while :; do
		echo
		echo
		echo
		echo "------------------------"
		echo "1: install nginx"
		echo "2: install tomcat"
		echo "3: install docker"
		echo "------------------------"
		
		read APP 
		echo "***Your choice is ${APP}."
		
		case $APP in 
			"q" | "Q" )
				exit 0
			;;

			"1") 
				echo "Install nginx."
				get-nginx
			;;
			"2" )	
				echo "Install tomcat."
			;;
			"3" )
				echo "Install docker."
			;;
			"4" )
				echo "Install promethues."
			;;
		esac

	done
}

get-nginx(){
	echo "Waitting for nginx install..."

}
main
