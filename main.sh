#!/bin/bash

function list() {
	
	status=$(nmcli radio wifi)
	if [[ $status == "enabled" ]]; then
		echo "The available wifi networks are : "
		nmcli -f SSID device wifi list | awk 'NR>1 && $1 != "--"' | sort | uniq
	
	else 
		echo "Turn on wifi to list available networks"
	fi
}

list

function on() {
		
	status=$(nmcli radio wifi)

	if [[ $status == "enabled" ]]; then
		echo "Wifi is up and running"
	else 
		echo "Turning on wifi..."
		nmcli radio wifi on
		echo "Wifi is up and running"
	fi
}
on

function off() {
	
	status=$(nmcli radio wifi)
	
	if [[ $status == "enabled" ]]; then
		echo "Turning the Wifi off"
		nmcli radio wifi off
		echo "Wifi turned off"
	else
		echo "Wifi already turned off"
	fi

}
# off

function status() {
	
	status=$(nmcli radio wifi)
	if [[ $status == "enabled" ]]; then
		echo "Wifi is up and running"
	else
		echo "Wifi is turned off"
	fi
}
