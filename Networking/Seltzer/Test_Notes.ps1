################################################################################################################################################################################################################

                                                                                                   #First Steps on a Box#

################################################################################################################################################################################################################
Net Recon Methodology
1. Host Discovery (nmap, scan.sh, nc, ping sweep, traceroute)
2. Service/Port Discovery (nmap, scan.sh, nc)
3. Port Validation (banner grabbing - nc <ip> <port>)
4. Follow-on Actions based on ports found
 a. if port is 21 or 80: wget -r ftp://<ip address> OR wget -r <ip address> (no need for http://)
 b. if port is 22 or 23: connect to it and do situational awareness

Scan Methodology
1. Quick scan ports: 21-23,80
2. Specific ports based on hints/clues found
3. Well Known Ports: 1-1023
4. Chunks of 2000 or start with first 10000
5. If all else fails scan all

Passive Recon Methodology
1. Get the host name (hostname)
2. interfaces and subnets (ip a, ifconfig)
3. Neighbors (arp -a, ip route, ip neigh (or ip neigh | grep -vi failed))
4. Files of interest (pcaps, flags, etc - find) 
5. Other ports listening (netstat or SS -nltp)
6. Available tools (which tcpdump wireshark nmap telnet wget curl)
 a. We may also have to sniff for additional creds in the clear -- use tcpdump to sniff for telnet traffic

################################################################################################################################################################################################################

                                                                                              #Basic Commands#

################################################################################################################################################################################################################
#Below are a series of useful commands installed on this Internet_Host to use while you are in this course.
    #1. To view your IP address and interface information:
        a. current =        ip address (ip addr)
        b. deprecated =     ifconfig

    #2. To view your ARP cache:
        a. current =        ip neighbor (ip nei)
        b. deprecated =     arp -a

    #3. To view open TCP and UDP sockets:
        a. current = 
            i. TCP =        ss -antlp
            ii. UDP =       ss -anulp
        b. deprecated =     netstat

    #4. To view active processes:
        a. static =         ps -elf
        b. real-time =      top or htop

    #5. To open file manager from the command line or X11 connection:
        a. nautilus
        b. pcmanfm

    #6. Web Browsers:
        a. Firefox
        b. Chromium
        c. Konqueror

    #7. To open images from the command line or X11 connection:
        a. Eye of Gnome =                   eog [file]
        b. Nomacs =                         nomacs [file]
        c. Eye of Mate =                    eom [file]
        d. GNU Image Manipulation Program = gimp [file]

    #8. Network scanning:
        a. nmap
            -sT = TCP Full connection
            -sS = TCP SYN scanning
            -Pn = Disable ping sweep
            -sU = UDP scanning
        b. zenmap
        c. netcat
            TCP: nc -nzvw1 10.10.0.40 21-23 80
            UDP: nc -unzvw1 10.10.0.40 53 69
        d. ping
        e. traceroute

    #9. Network Utilization:
        a. iftop
        b. iptraf-ng

    #10. Packet Manipulation (requires root privileges):
        a. scapy
        b. hping3
        c. yersinia     yersinia -G

    #11. Packet Sniffing (requires root privileges):
        a. Wireshark
        b. tcpdump
        c. p0f
        d. tshark

    #12. Banner Grabbing:
        a. netcat
            Client: nc 10.10.0.40 22
            Listener: nc -lvp 1234
        b. telnet
            telnet 10.10.0.40
        c. wget
            wget -r http://10.10.0.40
            wget -r ftp://10.10.0.40
        d. curl
            curl http://10.10.0.40
            curl ftp://10.10.0.40

    #13. DNS Query:
        a. whois
        b. dig
            Records:
                A - IPv4
                AAAA - IPv6
                NS - Name Server
                SOA - Start of Authority
                MX - Mail Server
                TXT - Human readable message

    #14. Remote access:
        a. ssh
            ssh student@10.10.0.40
            ssh student@10.10.0.40 -p 2222
        b. telnet
            telnet 10.10.0.40
            telnet 10.10.0.40 23

    #15. File Transfer:
        a. scp
            scp student@10.10.0.40:file .
            scp file student@10.10.0.40:
        b. netcat
            nc 10.10.0.40 1234 < file
            nc -lvp 1234 > file

################################################################################################################################################################################################################

                                                                                                    #Some Extra Tools#

################################################################################################################################################################################################################
for i in {1..254} ;do (ping -c 1 192.168.1.$i 2> /dev/null | grep "bytes from" &) ;done

sudo iptables -t mangle -A POSTROUTING -j TTL --ttl-set 254       #how to cange ttl to match a typical cisco device

################################################################################################################################################################################################################

                                                                                                    #Tunneling#

################################################################################################################################################################################################################
                                                   #For examples basic map
                    IH ---------(22)> Host_1 ---------(22)> Host_2 (80)---------(22,23,80)> Host_3 (22)
        
#Tunneling
    #SSH
        #multichannel connection
        #SSH Local Port Forwarding
          ssh -p <optional alt port> <user>@<pivot ip> -L <local bind port>:<tgt ip>:<tgt port> -NT
          ssh -L <local bind port>:<tgt ip>:<tgt port> -p <alt port> <user>@<pivot ip> -NT
          #local port forwarding through a local port
            ssh student@localhost -p 1111 -L 2222:172.16.82.106:80 -NT
            #when on a box can use localhost instead of retyping the ip again
        #SSH Dynamic Port Forwarding
          #USE DYNAMIC TO GET TOOLS FROM MY IH TO THE BOX IM WORKING ON
          #Basic Syntax
            ssh -D <port> -p <alt port> <user>@<pivot ip> -NT
          #Proxychains default port is 9050
          #Creates a dynamic socks4 proxy that interacts alone, or with a previously established remote or local port forward
          #Allows the use of scripts and other userspace programs through the tunnel.
          #1 step forwarding
            ssh student@172.16.82.106 -D 9050 -NT
          #2 step forwarding
            ssh <user>@172.16.82.106 -L 1111:10.10.0.40:22 -NT
            ssh student@localhost -D 9050 -p 1111 -NT
          #exs
            IH> ssh user@host_1 -L 1111:Host_2:22 -NY
            IH> ssh -p user@localhost -D 9050 -NT
            IH> proxychains ftp Host_3
            IH> proxychains nc
            IH> proxychains nmap -Pn
            IH> proxychains curl
                  #Default port for proxychains is 9050
                      #why we use it with dynamic ports
        #Remote Port Forwarding
          #Basic Syntax
              ssh -p <optional alt port> <user>@<remote ip> -R <remote bind port>:<tgt ip>:<tgt port> -NT
              or
              ssh -R <remote bind port>:<tgt ip>:<tgt port> -p <alt port> <user>@<remote ip> -NT
          #SSH Remote and local port forwarding
              Blue Private Host-1:
              ssh student@172.16.82.106 -R 1111:localhost:22 -NT
              
              Internet Host:
              ssh student@172.16.82.106 -L 2222:localhost:1111 -NT
              
              Internet Host:
              ssh localhost -p 2222
              
              #Creates a remote port on a remote machine, staging a connection
              #also creates a local pot on the local  host to connect to the previously staged connection 
          #exs
              Blue Host-1
              ssh student@10.10.0.40 -R 1111:localhost:80 -N
                  #creates a remote port on remotes local host that forwards to the target specified
Tunnels
~~~~~~~
First Tunnel is going out from IH to a box to enable me to telnet from my ih to the box to it
    there is a box inbetween one using port 23 and my orig IH that is my redir for this network.  Using its 7777(ssh) to access that box and move into network)
ssh -p 7777 net3_student15@10.50.24.41 -L 31500:10.2.2.7:23 -NT

This is a remote tunnel back from the device I telneted to so i can set up a port to access ssh (was set to random high of 2222) and use as a jump through network
    7777 is allowing to use redir box to jump to that box setting this new port up on redir to talk to 2222 on tar box
ssh -p 7777 net3_student15@10.2.2.6 -R 31501:localhost:2222 -NT

This is allowing to just direct from IH to target using the redir as a stepping stone to access target
ssh -p 7777 net3_student15@10.50.24.41 -L 31502:localhost:31501 -NT

these are tunnels adding onto the tunnels made before, reaching out setting up ports on custom ssh high ports to be able to access them via dynamic tunnels
ssh net3_student15@localhost -p 31502 -L 31503:10.10.10.140:301 -NT
ssh net3_student15@localhost -p 31502 -L 31504:10.10.10.167:404 -NT
################################################################################################################################################################################################################

                                                                                              #Berkley Packet Filters#

################################################################################################################################################################################################################
            tcpdump {A} [B:C] {D} {E} {F} {G}

            A = Protocol (ether | arp | ip | ip6 | icmp | tcp | udp)
            B = Header Byte offset
            C = optional: Byte Length. Can be 1, 2 or 4 (default 1)
            D = optional: Bitwise mask (&)
            E = Operator (= | == | > | < | <= | >= | != | () | << | >>)
            F = Result of Expresion
            G = optional: Logical Operator (&& ||) to bridge expressions
                #Protocols
                    ip              #ipv4 header
                    ip6             #ipv6 header
                    arp             #arp header
                    icmp            #icmp header
                    tcp             #tcp header
                    udp             #udp header
                    ether           #ethernet header
                #Examples
                    tcpdump 'ether[12:2] = 0x0800 && (tcp[2:2] != 22 && tcp[2:2] != 23)'
                                      #from ethernet header pulling the ethertype
                                      #showing where ethertype is equal to 0x0800 (ipv4)
                                      #and from tcp header pulling dst port
                                      #and where that port is nt equal to 23
                    tcpdump 'ip[9]=17||ip6[6]=0x11'
                                      #get all ipv4 and ipv6 udp protocols
                    tcpdump 'ether[12:2]=0x0806'
                                      #gets all arp traffic
                    tcpdump 'ip[6]&128=128'
                                      #gets all with evil bit set
                    tcpdump 'ip[9]=16'
                                      #gets all with the chaos protocol
                    tcpdump 'ip[1]>>2=37'
                                      #gets all traffic with dscp value of 37
                    tcpdump 'tcp[13]&32!=32&&tcp[18:2]>0'
                                      #gets all where urg flag is not set and urg pointer has a value
                    tcpdump 'ip[8]=1&&(ip[9]=1||ip[9]=0x11)'
                                      #gets the beginning of traceroutes for windows and linux entering the system
                                      
#Using BPF’s, determine how many packets with a DSCP of 26 being sent to the host 10.0.0.103.
    tcpdump 'ip[1]>>2=26&&ip[16:4]=0x0a000067' -r /usr/share/cctc/capstone-bpf.pcap | wc -l
                (ip 1 for dscp)     (dst addr = ip[16:4} = hex of ip)
                (>>2 to not have last two bits that arent dscp)

What is the total number of fragmented packets?
    tcpdump '((ip[6:2] > 0) && (not ip[6] = 64))' -r /usr/share/cctc/capstone-bpf.pcap | wc -l

How many packets have the DF flag set and has ONLY the RST and FIN TCP Flags set?
    tcpdump 'ip[6]&64=64 && tcp[13]=0x05' -r /usr/share/cctc/capstone-bpf.pcap | wc -l
              (need &64=64 not just =64)
              (0x05 is the FIN RST flag)

An attacker is targeting the host 10.0.0.104 with either a TCP full or half open scan. Based off the pcap, how many ports are open?
    tcpdump 'tcp[13]=0x12 && ip[12:4]=0x0a000068' -r /usr/share/cctc/capstone-bpf.pcap | wc -l

When a machine is being attacked via a port use tcpdump to scan and see attack happening
    tcpdump -i <interface> -X 'tcp[2:2]=<port>'

sudo iptables -t mangle -A POSTROUTING -j TTL --ttl-set 254       #how to cange ttl to match a typical cisco device

################################################################################################################################################################################################################

                                                                                                       #Snort#

################################################################################################################################################################################################################
#EXAMPLES FOR SNORT
    ls /etc/snort                       #shows files in snorts dir
    cat /etc/snort/snort.conf
    
    sudo snort -V                       #Seeing if snort on system
    ps -elf | grep snort                #check if snort running
    
    sudo snort -D -l /var/log/snort -c /etc/snort/snort.conf
                                        #start snort
    cat /var/log/snort/alert            #view alerts
    
    ls /var/log/snort                   #contains alerts and a pcap for logs (can view pcap with wireshark or tcpdump)
    
    sudo tcpdump /var/log/snort/snort.log.1684159868 | awk '{print $2} {print $4}' | sort | sed 's/:$//' | uniq -c
                                        #fancy way to view a log (makes output nice and organized

#Snort
    #Header
        [action] [protocol] [s.ip] [s.port] [direction] [d.ip] [d.port] ( match conditions ;)
            #Action - such as alert, log, pass, drop, reject
            #Protocol - includes TCP, UDP, ICMP and others
            #Source IP address - single address, CIDR notation, range, or any
            #Source Port - one, multiple, any, or range of ports
            #Direction - either inbound or in and outbound
            #Destination IP address - options mirror Source IP
            #Destination port - options mirror Source port
