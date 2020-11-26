#!/bin/bash

fun_set_text_color(){
    COLOR_RED='\E[1;31m'
    COLOR_GREEN='\E[1;32m'
    COLOR_YELOW='\E[1;33m'
    COLOR_BLUE='\E[1;34m'
    COLOR_PINK='\E[1;35m'
    COLOR_PINKBACK_WHITEFONT='\033[45;37m'
    COLOR_GREEN_LIGHTNING='\033[32m \033[05m'
    COLOR_END='\E[0m'
}

flag_header(){
    echo ""
    echo "+---------------------------------------------------------+"
    echo "|                 Easy AutoRecon Installer                |"
    echo "+---------------------------------------------------------+"
    echo "|              A tool to auto-recon ctf boxes             |"
    echo "+---------------------------------------------------------+"
    echo "|                          Enjoy                          |"
    echo "+---------------------------------------------------------+"
    echo ""
}

check_sudo(){
  if [[ $EUID -ne 0 ]]; then
          echo "Error:This script must be run as root/sudo!" 1>&2
          exit 1
  fi
}

shell_update(){
  echo -e " [${COLOR_BLUE}UPDATING SHELL${COLOR_END}]"
  sudo apt-get update -y
  sudo apt-get --fix-broken install -y
  sudo apt-get install sudo git -y
  echo -e " [${COLOR_GREEN}SHELL UPDATED${COLOR_END}]"
}

python_update(){
	echo -e " [${COLOR_BLUE}UPDATING PYTHON${COLOR_END}]"
    sudo apt install python3 -y
    sudo curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
    sudo python3 get-pip.py --user pipx
    sudo python3 -m pipx ensurepath
    echo -e " [${COLOR_GREEN}PYTHON UPDATED${COLOR_END}]"
}

AutoRecon_install(){
  	echo -e " [${COLOR_BLUE}INSTALLING AUTORECON${COLOR_END}]"
    sudo python3 -m pip install git+https://github.com/Tib3rius/AutoRecon.git
    echo -e " [${COLOR_GREEN}AUTORECON INSTALLED${COLOR_END}]"
}

Additional_install(){
	echo -e " [${COLOR_BLUE}INSTALLING ADDITIONAL TOOLS${COLOR_END}]"
    sudo apt install seclists curl enum4linux gobuster nbtscan nikto nmap onesixtyone oscanner smbclient smbmap smtp-user-enum snmp sslscan sipvicious tnscmd10g whatweb wkhtmltopdf -y
    echo "Defaults	secure_path="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/home/kali/.local/bin"" >> /etc/sudoers
    echo -e " [${COLOR_GREEN}TOOLS INSTALLED${COLOR_END}]"
}

Clean(){
	echo -e " [${COLOR_BLUE}CLEANING UP${COLOR_END}]"
    sudo apt-get -y autoremove && apt-get -y autoclean
    echo -e " [${COLOR_GREEN}ALL CLEAN${COLOR_END}]"
    echo -e " [${COLOR_PINK}FINISHED${COLOR_END}]"
}

# Start
clear
fun_set_text_color
check_sudo
flag_header
shell_update
python_update
AutoRecon_install
Additional_install
Clean
exit 0
