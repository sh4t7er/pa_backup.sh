#!/bin/bash
# 
# Palo Alto automated backup script - Brandon Filbert
# 
# Requirements: bash, curl
#
# Reference: https://knowledgebase.paloaltonetworks.com/KCSArticleDetail?id=kA10g000000Cm7yCAC
# Gererate API Key: https://<firewall-ip>/api/?type=keygen&user=<username>&password=<password>
# Download running-config: https://<firewall-ip>/api/?type=export&category=configuration&key=<api_key>
#

# Set working driectory
cd /path/to/backup/directory

# Declare variables and arrays
declare -a pa_names
declare -a pa_ips
declare -a pa_keys
declare -i arrval=0
declare -i err=0

# PA 1
pa_names[0]="PA Name" #Firewall name will appear in file name and log
pa_ips[0]="IP Address or Hostname" #IP or hostname of firewall
pa_keys[0]="API Key" #Firewall's API key 

# PA 2
#pa_names[1]="PA Name"
#pa_ips[1]="IP Address or Hostname"
#pa_keys[1]="API Key"

# PA 3
#pa_names[2]="PA Name"
#pa_ips[2]="IP Address or Hostname"
#pa_keys[2]="API Key"

# PA 4
#pa_names[3]="PA Name"
#pa_ips[3]="IP Address or Hostname"
#pa_keys[3]="API Key"

# Array iteration loop
for i in "${pa_names[@]}"
do
	# Get date and time
	date="$(date +%Y%m%d-%H%M%S)"

	# Generate URL
	url="https://"${pa_ips[$arrval]}"/api/?type=export&category=configuration&key="${pa_keys[$arrval]}

	# Generate config backup filename
	configname=${pa_names[$arrval]}"_"$date".xml"

	# Grab PA config
	config=$(curl -kGf --connect-timeout 20 $url) 

	# Check for errors then output to log or save backup
	if test "$config" = ""
	then
		echo "$date - ${pa_names[$arrval]} failed. Possible invalid API key or connection timeout." >> pa_backup.log
		err=1
	elif test "${config:0:16}" = "<response status"
	then
		echo "$date - ${pa_names[$arrval]} failed. Possible invalid API key. Output: ${config:0:150}" >> pa_backup.log
		err=1
	else
	echo "$config" > $configname
	fi

	arrval+=1
done

# Success log entry
if test "$err" = 0
then
	echo "$date - Success." >> pa_backup.log
fi
