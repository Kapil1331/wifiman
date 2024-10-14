#!/bin/bash
function status() {
	
	status=$(nmcli radio wifi)
	if [[ $status == "enabled" ]]; then
#		echo "Wifi is up and running"
		return 0
	else
#		echo "Wifi is turned off"
		return 1
	fi
}

function list() {
	
	status
	if [[ $? -eq 0 ]]; then
		echo "The available wifi networks are : "
		nmcli -f SSID device wifi list | awk 'NR>1 && $1 != "--"' | sort | uniq
	
	else 
		echo "Turn on wifi to list available networks"
	fi
}

function on() {
		
	status
	if [[ $? -eq 0 ]]; then
		echo "Wifi is up and running"
	else 
		echo "Turning on wifi..."
		nmcli radio wifi on
		echo "Wifi is up and running"
	fi
}

function off() {
	
	status
	if [[ $? -eq 0 ]]; then
		echo "Turning the Wifi off"
		nmcli radio wifi off
		echo "Wifi turned off"
	else
		echo "Wifi already turned off"
	fi

}



function connect() {
	echo "Enter ssid" 
	read ssid
	nmcli device wifi connect "$ssid"

}

function listp() {
	echo"Listing Previously connected networks"
	nmcli connection show --ask | awk 'NR>1 && $3=="wifi"'{'print $1'}
}

function="$1"
$1





