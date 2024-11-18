#!/bin/bash


target=$1
port=$2
option=$3


echo -e "Usage: ./ctf-recon.sh <ip> <port> <option>\nOptions:\n  nmap\n  web\n  all"

if [ -z "$target" ] || [ -z "$port" ] || [ -z "$option" ]; then
    echo "Error: Missing arguments!"
    echo "Usage: ./ctf-recon.sh <ip> <port> <option>"
    exit 1
fi


if ! command -v tmux &>/dev/null; then
    echo "Error: tmux is not installed. Install it using your package manager."
    exit 1
fi


tmux new-session -d -s ctf-recon "echo 'Starting Recon Scans for $target'; bash"

case "$option" in
    nmap)
        echo "Running nmap scans in new tmux panes..."
        tmux split-window -h "echo '---- Starting rustscan ----'; rustscan -a $target | tee rust.txt"
        tmux split-window -v "echo '---- Starting nmap ----'; nmap -p- -T4 -A $target -vv | tee nmap.txt"
        ;;
    web)
        echo "Running web enumeration in new tmux panes..."
        tmux split-window -h "echo '---- Starting ffuf directory brute force ----'; ffuf -u 'http://$target:$port/FUZZ' -w /usr/share/dirb/wordlists/common.txt | tee ffuf.txt"
        tmux split-window -v "echo '---- Starting feroxbuster ----'; feroxbuster -u 'http://$target:$port' | tee ferox.txt"
        tmux split-window -h "echo '---- Starting nikto ----'; nikto -h $target | tee nikto.txt"
        ;;
    all)
        echo "Running all scans in new tmux panes..."
        tmux split-window -h "echo '---- Starting rustscan ----'; rustscan -a $target | tee rust.txt"
        tmux split-window -v "echo '---- Starting nmap ----'; nmap -p- -T4 -A $target -vv | tee nmap.txt"
        tmux split-window -h "echo '---- Starting ffuf directory brute force ----'; ffuf -u 'http://$target:$port/FUZZ' -w /usr/share/dirb/wordlists/common.txt | tee ffuf.txt"
        tmux split-window -v "echo '---- Starting feroxbuster ----'; feroxbuster -u 'http://$target:$port' | tee ferox.txt"
        tmux split-window -h "echo '---- Starting nikto ----'; nikto -h $target | tee nikto.txt"
        ;;
    *)
        echo "Invalid option: $option"
        echo "Usage: ./ctf-recon.sh <ip> <port> <option>"
        echo "Options: nmap, web, all"
        exit 1
        ;;
esac


tmux attach-session -t ctf-recon
