#!/bin/bash

# Colori di testo base
white="\033[0;37m"        # Bianco
online_color="\033[1;32m"  # Verde lime per online
offline_color="\033[1;31m" # Rosso per offline
reset_color="\033[0m"      # Reset del colore

# Mappa indirizzi IP ai nomi dei dispositivi
declare -A servers
servers=(
    ["192.168.1.116"]="Server name"
    ["192.168.1.238"]="Server name2"
)

# Funzione per fare il ping a un server
check_server() {
    ip=$1
    device_name=$2
    ping -c 1 $ip &> /dev/null
    if [ $? -eq 0 ]; then
        echo -e "${online_color}●${reset_color} ${white}$device_name${reset_color} ($ip)  online"
    else
        echo -e "${offline_color}✖${reset_color} ${white}$device_name${reset_color} ($ip)  offline"
    fi
}

# Ciclo infinito per controllare ogni 30 secondi
while true; do
    # Pulisce l'output precedente
    clear

    # Stampa il titolo con una riga di spazio
    echo -e "\nDevice on BT-C2A66H\n"
    
    # Esegui il controllo per ogni server
    for ip in "${!servers[@]}"; do
        device_name=${servers[$ip]}
        check_server $ip "$device_name"
    done
    
    # Aspetta 30 secondi prima di ripetere
    sleep 30
done

