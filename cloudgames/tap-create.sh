#!/bin/bash

for i in {0..7}
do
	echo ${i}
	sudo tunctl -t tap${i} -u `whoami`
	sudo brctl addif br0 tap${i}
	sudo ifconfig tap${i} up
done
