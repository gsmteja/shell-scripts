#!/bin/bash

#assign variable to the file

# content=$(cat users.csv) --> helps you to get contets which isa vailable in the fie

File="users.csv"

tail -n +2 "$File" | while read line
do 
	username=$(echo $line | cut -d',' -f1)
	password=$(echo $line | cut -d',' -f2)
	
#command that used to add user to linux server
	useradd "$username" 
	
	echo "$username:$password" | sudo chpasswd
	echo "Created user: $username"
done

# command to run the file --> $ sudo bash [filename].sh
	