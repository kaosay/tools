#!/bin/bash

#
# Install application of operations engineer
#

main(){

	TOOLS=( "nginx" "tomcat" "mysql" "docker" "redis" "promethues" "zabbix" "python" "git")
	
	#echo "${TOOLS[*]}"#
	echo "-------------------------------"	
	echo "--Install the following tools--"
	count=1
	for i in ${TOOLS[*]}; do
		echo -n $count"--"$i"  "
		count=$(( count+1 ))
	done
	echo

	while :; do
		read APP 
		echo "Your choice is ${APP}."
		
		if [[ ${APP} == "q" ||${APP} == "Q" ]]; then
			exit 0
		
		elif [[ $APP =~ ^[0-9]+$ ]]; then
			echo "Start install --${TOOLS[ $((APP-1)) ]}--"		
		fi
		
	done
}

get-nginx(){
	echo "Waitting for nginx install..."

}
main
