#!/bin/bash



#Colours
declare -r greenColour="\e[0;32m\033[1m"
declare -r endColour="\033[0m\e[0m"
declare -r redColour="\e[0;31m\033[1m"
declare -r blueColour="\e[0;34m\033[1m"
declare -r yellowColour="\e[0;33m\033[1m"
declare -r purpleColour="\e[0;35m\033[1m"
declare -r turquoiseColour="\e[0;36m\033[1m"
declare -r grayColour="\e[0;37m\033[1m"

export DEBIAN_FRONTEND=noninteractive

trap ctrl_c INT

function ctrl_c(){
	echo -e "\n${redColour}[*] Cancelled${endColour}\n"
	tput cnorm; exit 0
}

function helpPanel(){
	echo -e "\n${purpleColour}[*]${endColour}${grayColour} Uso: ./fastskan.sh${endColour}"
	echo -e "\n\t${yellowColour}[-s]${endColour} Server IP"
	echo -e "\t${yellowColour}[-w]${endColour} Wordlist"
	echo -e "\t${yellowColour}[-n]${endColour} Box Name"
	echo -e "\n${purpleColour}[Example]${endColour} ./fastskan.sh -s 10.10.10.10 -w wordlist.txt -n Jerry"
	exit 0
}

function dependencies(){
	tput civis
	clear; dependencies=(nmap gobuster whatweb)

  	 echo -e "${yellowColour}
  ______        _      _____ _               
 |  ____|      | |    / ____| |              
 | |__ __ _ ___| |_  | (___ | | ____ _ _ __  
 |  __/ _' / __| __|  \___ \| |/ / _' | '_ \ 
 | | | (_| \__ \ |_   ____) |   < (_| | | | |
 |_|  \__,_|___/\__| |_____/|_|\_\__,_|_| |_|              
		${endColour}"
	echo -e "- by ${yellowColour}K${endColour}ryot\n\n"
	
	echo -e "${purpleColour}[*] Checking dependencies...${endColour}"
	sleep 1
	
	for program in "${dependencies[@]}"; do
		echo -e "\n${yellowColour}[*]${endColour} $program ..."
	
		test -f /usr/bin/$program
	
		if [ "$(echo $?)" == "0" ]; then
			echo -e "${greenColour}Installed${endColour}"
		else
			echo -e "${redColour}Not Installed${endColour}"
			echo -e "\n${yellowColour}[*]${endColour} Installing $program"
			apt-get install $program -y > /dev/null 2>&1
		fi; sleep 1
	done
}

function startAttack(){

	echo -e "\n${purpleColour}[*] Starting Fast Enumeration${endColour}\n"
	echo -e "${yellowColour}[*]${endColour} Open Ports"; nmap -F $ip | grep -i "open"
	echo -e "\n${purpleColour}[*] Starting Nmap Complete Skan${endColour}\n"
	mkdir ${name}
	cd ${name}
	mkdir FastSkan
	cd FastSkan
	nmap -sV -Pn -sC $ip -o ${name}ports > /dev/null 2>&1
	echo -e "${yellowColour}[*]${endColour} File ${name}ports created"
	echo -e "\n${purpleColour}[*] Fuzzing Directories${endColour}\n"
	gobuster dir -u $ip -w $wordlist -o ${name}dirs -t 50 > /dev/null 
	echo -e "${yellowColour}[*]${endColour} File ${name}dirs created"
	echo -e "\n${purpleColour}[*] Starting WhatWeb Skan${endColour}\n"
	whatweb $ip > ${name}whatweb
	echo -e "${yellowColour}[*]${endColour} File ${name}whatweb created"
	echo -e "\n${greenColour}[*] Successful Skan${endColour}\n"

}

#Main

if [ "$(id -u)" == "0" ];then 

	declare -i parameter_counter=0; while getopts ":s:w:h:n:" arg; do
		case $arg in
			s) ip=$OPTARG; let parameter_counter+=1;;
			w) wordlist=$OPTARG; let parameter_counter+=1;;
			h) helpPanel;;
			n) name=$OPTARG ; parameter_counter+=1;;
		esac
	done
	
	if [ $parameter_counter -ne 3 ]; then
		helpPanel
	else
		dependencies
		startAttack
		tput cnorm
	fi
else
	echo -e "\n${redColour}[*] You need to be root${endColour}\n"
fi


