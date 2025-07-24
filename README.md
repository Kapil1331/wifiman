# Simplified WiFi Connection Manager

## Usage:
- **status**      : Get the current status of WiFi  
- **list**        : List the available networks  
- **on**          : Turn the WiFi on  
- **off**         : Turn the WiFi off  
- **connect**     : Connect to a particular SSID  
- **listp**       : List the previously connected networks  
- **speed**       : Check the Download and Upload speed of the currently connected network  
- **disconnect**  : Disconnect from the currently connected network

## Enable script to execute Globally
- sudo cp wifiman /usr/local/bin/

## Enable Auto-completion
- sudo cp wifiman_completion.sh /etc/bash_completion.d/
- exec $SHELL
