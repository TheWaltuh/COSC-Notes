############################################################################################################################################################

                                                               #Network Reconnaissance#

############################################################################################################################################################
                                CAN USE duckduckgo TO SEARCH FOR AN IP AND CIDER TO GET INFO ON THE NETWORK RANGE
                                ex in duckduckgo search 10.10.0.40/27
#Types of Recon
https://git.cybbh.space/net/public/raw/master/modules/networking/slides/images/Recon2.png
    #Active
      #The attacker actively sends packets to learn about a target system
      #Methods
        #DNS Queries
        #ARP Requests
        #Network Scanning
    #Passive
      #The attacker listens to whats going on without sending packets to learn about the system
          #Without direct interaction
          #lower risk of discovery
      #Involves identifying 
          #IP addresses and Sub-Domains
          #External and 3rd party sites
          #People and Technologies
          #Content of Interest
          #Vulnerabilities
      #Tools
        #WHOIS queries
        #Job site listings
        #Phone Numbers
        #Google searches
        #Passive OS fingerprinting
        #DNS Lookups
        #Whois
        #Job Site Listings
        #Packet Sniffers
    #Internal
      #done from inside the network
      #Methods
        #DNS Queries
        #ARP Requests
        #Packet Sniffers
    #External
      #done from outside the network
      #Methods
        #Job Site Listings
        #Network Scanning
      #Passive External
        #information gathered from outside the network using passive methods
        #Allows for more efficent attacks and plans
        #DNS
          #DNS Lookups
          #Ressolves hostnames to ip addresses
          #RFC 3912
          #Whois Queries
              whois google
              whois typeracer.com
              whois technometalpost.com
          nslookup
              nslookup www.google.com
        #DIG
          #Typically between primary and secondary DNS Servers
          #If allowed to transfer external hostnames, ips, and ip blocks can be determined
          #dig command
            #A = IPv4
            #AAAA = Ipv6
            #MX = Mail Server
            #SOA = Start of Authority
            dig ccboe.net
                <website>
        #Zone Transfers
          #returns DNS Information
          #Supplements base queries
          dig axfr @nsztm1.digi.ninja zonetransfer.me
                       <website>    
          dig axfr @ns1.google.com www.google.com
        #Host History
          #netcraft
          #wayback machine
        #Google Searches
          #subdomains
          #technologies
          #google dorking
            filetype:pdf
        #SHODAN
          #reveals information about technologies, remote access services, imp[roperly configured services, and network infastructure
          #when selected can give additional information and applicable vulnerabilities

#Network Scanning
  #Scanning Strategy
      #Remote to Local
          #refers to a remote host, outside the boundary of a specific network, performing some sort of scan on hosts internal to an enterprise network
      #Local to Remote
          #occurs when a host, within the administrative control of an enterprise network, scans systems outside the network boundary
      #Local to Local
          #refers to a host that scans systems within the boundaries of an enterprise in which it resides
      #Remote to Remote
          #does not depend on certain boundaries
          #mainly refers to world wide scanning campaigns
  #Scanning approach
      #Aim
          #Wide Range Target Scan
              #typically little human interaction involved (auto-rooters, automated to scan a network for vulnerable machines)
          #Target Specific Scan
              #focused scanning of a predetermined target host or network (botnet scanning or low and slow scan)
      #Method
          #Single Source Scan
              #operates from a one to many fashion
          #Distributed Scan
              #multiple systems in a union to scan a network or host of interest
  #Tools
      fping
      hping3
      arping
      nmap
      netcat
#Active External Network Recon: Host Discovery
  #Broadcast Ping/Ping Sweep
      fping -g -a 10.1.0.0/24
      nmap –sn 10.0.0.0/24                          #was -sP which is now deprecated
      for i in {1..254}; do ping -c 1 -W 1 10.1.1.$i | grep 'from'; done
  #ARP Scan
      sudo arp-scan --interface=eth0 --localnet
      sudo arp-scan --interface=eth0 10.1.0.0/24
      
      arping –c 1 –i eth0 172.16.32.2 (can only scan a single host, results vary)
      
      for ip in $(sew 1 254) ; do if ping -c 1 10.1.0.$ip>/dev/null; then echo "10.1.0.$ip UP"; fi ;done
      
      nmap –PR 172.16.32.2                          #legitimate scan that often does not show results
      nmap -PR -6 fe80::f816:3eff:fed9:5116/64      #takes a long time to run
                                #For Examples of all the different types of scans see FG
#NMAP Basics
  sudo nmap 
            -n #disable name resoultion
            -P #print off the ping code
  sudo nmap -Pn 10.10.1.0,5,55,70
        #scans for multi ips in one scan

#Subnetting Chart
        128       64        32        16        8       4        2       1
             +=
        128       192       224       240       248     252      254     255
      ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      | /1    |   /2    |   /3    |   /4    |   /5    |  /6   |  /7   |  /8  |
      ------------------------------------------------------------------------
A /8  | /9    |   /10   |   /11   |   /12   |   /13   |  /14  |  /15  |  /16 |
      ------------------------------------------------------------------------
B /16 | /17   |   /18   |   /19   |   /20   |   /21   |  /22  |  /23  |  /24 |
      ------------------------------------------------------------------------
C /24 | /25   |   /26   |   /27   |   /28   |   /29   |  /30  |  /31  |  /32 |
      ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~




