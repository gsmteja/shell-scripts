#!/bin/bash
echo "-------------------------------"
echo "Service health report"
echo "-------------------------------"


services=("ssh")

for service in "${services[@]}"; do
	if systemctl is-active --quiet "$service"; then
		echo "$service is Running!"
	else
		echo "$service Service is Stopped"
		
		echo "$service attempting to restart"
		sudo systemctl restart $service
		if systemctl is-active --quiet "$service"; then
			echo "$service has been restart seuccessfully"
		else
			echo "Failed to restart $service. check logs"
		fi
	fi
	echo "___________________________"
done

# to run this file use cmd --> sudo bash [filename].sh