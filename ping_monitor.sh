#!/bin/bash

# Colori di testo base 
online_color="\033[32m"   #"\033[1;32m"  # Verde lime per online
offline_color="\033[38;2;191;97;106m" # Rosso per offline
reset_color="\033[0m"      # Reset del colore
date=$(date "+%H:%M:%S")
ip_pubblico=$(curl -s https://api.ipify.org)
ssid=$(iwgetid -r)
ipcol="\033[38;2;236;239;244m\033[48;2;26;27;38m"
symbol=""

# Mappa indirizzi IP ai nomi dei dispositivi
declare -A servers
servers=(
    ["192.168.1.116"]="Server Lenovo"
    ["192.168.1.238"]="Cam Ezviz"
    ["192.168.1.252"]="MSH300HK HUB"
    ["192.168.1.241"]="Mac mini"
    ["192.168.1.200"]="Piantana"
    ["192.168.1.188"]="Lampada"
    ["192.168.1.160"]="LED 2"
    ["192.168.1.144"]="Stufa"
    ["192.168.1.201"]="LG Monitor-4K"
    ["192.168.1.232"]="LED 1"
    ["192.168.1.67"]="Ventilatore"
    ["192.168.1.202"]="Asus linux"
    
)

# Funzione per fare il ping a un server
check_server() {
    ip=$1
    device_name=$2
    ping -c 1 $ip &> /dev/null
    if [ $? -eq 0 ]; then
        echo -e "   ${online_color}● ${reset_color}$ip├── $device_name"
    else
        echo -e "   ${offline_color}● $ip${reset_color}├── $device_name${reset_color} "
    fi
}

# Funzione per controllare lo stato della rete
check_network() {
    date=$(date "+%H:%M:%S")
    ip_pubblico=$(curl -s https://api.ipify.org)
    ssid=$(iwgetid -r)
    if [ -z "$ssid" ]; then
       echo -e "\n   ${offline_color}● Disconnect${reset_color} \033[38;5;214m$date\033[0m \n"  # Rete non connessa
       
    else
        echo -e ""
        echo -e "  ${online_color}● ${reset_color}$ip_pubblico \033[38;5;39m$ssid\033[0m \033[38;5;214m$date\033[0m "
        echo -e ""
    fi
}

# Ciclo infinito per controllare ogni 30 secondi
while true; do
    # Pulisce l'output precedente
    clear
    check_network
 
    # Esegui il controllo per ogni server
    for ip in "${!servers[@]}"; do
        device_name=${servers[$ip]}
        check_server $ip "$device_name"
    done
    
    # Aspetta 30 secondi prima di ripetere
    sleep 30
done

