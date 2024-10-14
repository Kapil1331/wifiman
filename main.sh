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
	if listp | grep -q "$ssid"; then
		password=$(nmcli connection show "$ssid" --show-secrets | grep -i .psk: | awk '{print $2}') 
		nmcli device wifi connect "$ssid" password "$password"
		if [ $? -eq 0 ]; then
    			echo "Successfully connected to $ssid"
		else
    			echo "Failed to connect to $ssid"
		fi
	else
		echo "The connection is not saved enter the password : "
		read password
		nmcli device wifi connect "$ssid" password "$password"
	fi


}

function listp() {
	echo "Listing Previously connected networks"
	nmcli connection show | awk 'NR == 1 {
    		name_start = index($0, "NAME");
		uuid_start = index($0, "UUID");
		type_start = index($0, "TYPE");
		device_start = index($0, "DEVICE");
		}
		NR > 1 {
			type = substr($0, type_start, device_start - type_start);
			gsub(/^[[:space:]]+|[[:space:]]+$/, "", type);
			if(type == "wifi"){
				name_content = substr($0, name_start, uuid_start - name_start);
    				gsub(/^[[:space:]]+|[[:space:]]+$/, "", name_content);
    				print name_content;
			}
		}' | sort | uniq

}
function="$1"
$1
