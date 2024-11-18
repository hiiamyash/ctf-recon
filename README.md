This bash script automates reconnaissance tasks for CTFs using tmux.
Usage
Copy code
./ctf-recon.sh <ip> <port> <option>
Options:
nmap - Runs Nmap and Rustscan.
web - Runs web enumeration tools: ffuf, feroxbuster, nikto.
all - Runs both nmap and web scans.
Requirements
tmux, rustscan, nmap, ffuf, feroxbuster, nikto
Example
./ctf-recon.sh 192.168.1.1 80 all
