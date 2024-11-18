# ctf-recon.sh

Simple overview of use/purpose.

## Description

This bash script automates reconnaissance tasks for CTFs using tmux
Options:
nmap - Runs Nmap and Rustscan.
web - Runs web enumeration tools: ffuf, feroxbuster, nikto.
all - Runs both nmap and web scans.

## Getting Started

### Dependencies

* tmux, rustscan, nmap, ffuf, feroxbuster, nikto

### Installing

* git clone 

### Executing program

* chmod +x ctf-recon.sh
* ./ctf-recon <targetip> <port> <ports>
```
chmod +x ctf-recon.sh
./ctf-recon
```



