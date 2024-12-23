#!/bin/bash

echo Hello, And welcome to our login services
echo Press 1 to login
echo Press 2 to signup

read USER_INP

if [ "$USER_INP" = "2" ]; then
	echo USERNAME
	read username
	echo PASSWORD
	read password
	echo STATUS
	IFS= read -r status

	if [ "$username" = "" ]; then
		echo INVALID CREDENTIALS
	elif [ $"password" = "" ]; then
		echo INVALID CREDENTIALS
	elif [ "$status" = "" ]; then
		echo INVALID STATUS
	fi

	values=$(awk -F ',' -v usern="$username" '$1 == usern { print $0 }' data.csv)

	if [ "$values" = "" ]; then
		echo "$username,$password,$status" >> data.csv
	else
		echo "Username already exists"
	fi


elif [ "$USER_INP" = "1" ]; then
	echo Username 
	read username
	echo Password 
	read password
	
	ALL_VALUES=$(awk -F ',' -v usern="$username" -v psswd=$password '$1 == usern && $2 == psswd { print $0 }' data.csv)

	if [ "$ALL_VALUES" = "" ]; then
		echo INVALID CREDENTIALS
	else
		username=$(echo $ALL_VALUES | awk -F',' '{print $1 }')
		status=$(echo $ALL_VALUES | awk -F ',' '{print $3 }')
		echo Welcome $username!
		echo Press 1 to LOGOUT
		echo Press 2 to print STATUS
		read USER_INP2
		if [ "$USER_INP2" = "2" ]; then
			echo STATUS: $status
		elif [ "$USER_INP2" = "1" ]; then
			echo SEE YOU NEXT TIME @$username!!!! 
		else
			echo Incorrect Input
		fi
	fi

else
	echo Incorrect Input
fi
