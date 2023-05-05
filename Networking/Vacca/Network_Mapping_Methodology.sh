You need to map as you go.

Net Recon Methodology
1. Host Discovery (nmap, scan.sh, nc, ping sweep)
2. Service Discovery (nmap,scan.sh, nc)
3. Port Validation (e.g Banner Grabbing - nc)
4. Follow-on Actions (based on ports found)
	a. 21 or 80: wget -r ftp://IP -or- http://IP
	b. 22 or 23: connect and PASSIVE RECON

SCAN METHODOLOGY
1. Quick scan ports: 21-23,80
2. Specific Ports based on hints/clues
3. Well known ports: 1-1023
4. Chunks of 200 or first 10000
5. Hail Mary

PASSIVE RECON METHODOLOGY
1. hostname
2. Interfaces and subnets? ip a, ifconfig
3. Neighbors? arp -a, ip neigh
4. Files of interest (pcaps, flags, etc): find
5. netstat -or- ss -nltp (note filtered ports that did not show up on Recon)
6. wireshark nmap telnet wget curl tcpdump
	a. may also have to sniff for additional creds (telnet)














