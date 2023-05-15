####################################################################################################################################################################################################

                                                                                #Network Traffic Filtering#

####################################################################################################################################################################################################

#Filtering Devices & Mechanisms
    #Practical Applications for Filtering
        #Email Addresses - block unwanted email and increase productivity
        #Computer Applications (in an organization environment) - for security from vulnerable software
        #MAC Filtering - also for security to allow only specific computers access
        #Network Traffic
    #devices                                            #Filtering Mechanisms                                 #OSI Layer
      #Switches                                             #PACL & VALC ACLS                                     #Layer 2,3
      #Router                                               #ACL                                                  #Layer 3,4
      #Proxies                                              #Content based (URL/DNS Blacklists, etc)              #Layer 3-7
      #Intrusion Detection # Prevention Systems             #Signatures                                           #Layer 3-7
      #Host Based Firewall                                  #Rules                                                #Layer 3-7
      #Network Firewall                                     #Rules                                                #See below
                                                              #Packet Filtering (stateless)                           #Layer 3,4
                                                              #Stateful (Connection based)                            #Layer 3,4
                                                              #Application Layer FW                                   #Layer 3-7
                                                              #Next Generation FW                                     #Layer 3-7

    #Filtering Concepts
        #Whitelist (bloack all but what allowed) vs Blacklist
        #Default polocies and implicit and explicit rules
        #Network device operation modes
            #routed
            #Transparent
        #Intrusion Defense
            #Intrusion Detection Systems
            #Intrusion Prevention Systems
        #Filtering Device Placement
        #Firewall Filtering Methods
            #Stateless (Packet) Filtering (L3+4)
            #Stateful Inspection (L4)
            #Application Layer (L7)

#Netfilter Framework
    #Made to provide
        #Packet Filtering
        #Stateless/stateful Firewalls
        #Network Addresses and port translation (NAT and PAT)
        #Other packet manipulation
    #Netfilter Hooks
        #NF_IP_PRE_ROUTING --> Prerouting
        #NF_IP_LOCAL_IN -->Input
        #NF_IP_FORWARD --> Forward
        #NF_IP_LOCAL_OUT --> Output
        #NF_IP_POST_ROUTING --> Postrouting
    #Netfilter Paradigm
        #1 - Tables - Contain Chains
        #2 - chains - contain rules
        #3 - rules - dictate what to match and what actions to perform on packets when packets match a rule
        
#Configuration IPTables
    #Netfilter created several (seperate) applications to filter on different Layer 2 or Layer 3+ protocols
        #iptables - IPv4 packet administration
        #ip6tables - IPv6 packet administration
        #ebtables - ethernet bridge frame table administration
        #arptables - arp packet administration
    #Each application had several tables and chains
        #Filter - Default table. Provides packet filtering
            #INPUT, FORWARD, and OUTPUT
        #nat - used to translate private ←→ public address and ports.
            #PREROUTING, POSTROUTING, and OUTPUT
        #mangle - provides special packet alteration. Can modify various fields header fields.
            #All Chains: PREROUTING, POSTROUTING, INPUT, FORWARD and OUTPUT.
        #raw - used to configure exemptions from connection tracking
            #PREROUTING and OUTPUT
        #security - used for Mandatory Access Control (MAC) networking rules
            #INPUT, FORWARD, and OUTPUT
    #Syntax
        iptables -t <table> -A <chain> <rules> -j <action>
        https://git.cybbh.space/net/public/raw/master/modules/networking/slides/images/T51_iptables_options.png
            #List of iptables options
        #Flush table
            iptables -t [table] -F
        #Change default policy
            iptables -t [table] -P [chain] [action]
        #Lists rules with rule numbers
            iptables -t [table] -L --line-numbers
        #Lists rules as commands interpreted by the system
            iptables -t [table] -S
        #Inserts rule before Rule number
            iptables -t [table] -I [chain] [rule num] [rules] -j [action]
        #Deletes rule at number
            iptables -t [table] -D [chain] [rule num]
        #Allow traffic from x11 forwarded applications
            sudo iptables -A INPUT -p tcp -m multiport --ports 6010,6011,6012 -j ACCEPT
            sudo iptables -A OUTPUTp -m multiport --ports 6010,6011,6012 -j ACCEPT
        https://git.cybbh.space/net/public/raw/master/modules/networking/slides/images/T55_NAT&PAT_Chains.png
              #how to use NAT and PAT (Operators and chains)
        #Image below shows what command does to SOURCE NAT
            iptables -t nat -A POSTROUTING -o eth0 -j SNAT --to 1.1.1.1
            https://git.cybbh.space/net/public/raw/master/modules/networking/slides/images/Source_NAT_image.png
        #Another image related one to DESTINATION NAT
            iptables -t nat -A PREROUTING -i eth0 -j DNAT --to 10.0.0.1
            https://git.cybbh.space/net/public/raw/master/modules/networking/slides/images/Dest_NAT_image.png
        #SOURCE PAT SHIT
            iptables -t nat -A POSTROUTING -p tcp -o eth0 -j SNAT --to 1.1.1.1:9001
            https://git.cybbh.space/net/public/raw/master/modules/networking/slides/images/T16_Source_NAT_Graphic.png
        #DESTINATION PAT SHIT
            iptables -t nat -A PREROUTING -p tcp -i eth0 -j DNAT --to 10.0.0.1:8080
            https://git.cybbh.space/net/public/raw/master/modules/networking/slides/images/T17_DestPAT_graphic.png


#Configuration NFTABLES
    #NFTABLE Families
        #ip - IPv4 packets
        #ip6 - IPv6 packets
        #inet - IPv4 and IPv6 packets
        #arp - Layer 2
        #bridge - processing traffic/packets traversing bridges
        #netdev - allows for user classification of packets - nftables passes up to the networking stack (no counterpart in iptables)
    #Introduces chain-types
        #filter - to filter packets - can be used with arp, bridge, ip, ip6, and inet families
        #Route - to reroute packets - can be used with ip and ipv6 families only
        #nat - used for Network Address Translation - used with ip and ip6 table families only
    #Hooks
        #PREROUTING
        #POSTROUTING
        #INPUT
        #OUTPUT
        #FORWARD
        #INGRESS - used with NETDEV family only
    #Create the table syntax
        nft add table [family] [table]
            [family] = ip, ip6, inet, arp, bridge and netdev.
            [table] = user provided name for the table.
    #Create the base chain syntax
        nft add chain [family] [table] [chain] { type [type] hook [hook] priority [priority] \; policy [policy] \;}
            [chain] = User defined name for the chain.
            [type] =  can be filter, route or nat.
            [hook] = prerouting, ingress, input, forward, output or postrouting
            [priority] = user provided integer. Lower number = higher priority. default = 0. Use "--" before negative numbers.
            ; [policy] ; = set policy for the chain. Can be accept (default) or drop.
            Use "\" to escape the ";" in bash
    #Create a rule in the chain
        nft add rule [family] [table] [chain] [matches (matches)] [statement]
            [matches] = typically protocol headers(i.e. ip, ip6, tcp, udp, icmp, ether, etc)
                (matches) = these are specific to the [matches] field.
            [statement] = action performed when packet is matched. Some examples are: log, accept, drop, reject, counter, nat (dnat, snat, masquerade)

    #NAT AND PAT W/ NFTABLES
        #Create the NAT table
            nft add table ip NAT
        #Create the NAT chains
            nft add chain ip NAT PREROUTING {type nat hook prerouting priority 0 \; }
            nft add chain ip NAT POSTROUTING {type nat hook postrouting priority 100 \; }
    #CREATE THE NAT RULES
        #Source NAT
            nft add rule ip NAT POSTROUTING ip saddr 10.1.0.2 oif eth0 snat 144.15.60.11
        #Destination NAT
            nft add rule ip NAT PREROUTING iif eth0 tcp dport { 80, 443 } dnat 10.1.0.3
        #Source NAT w/ masquerade
            nft add rule ip NAT POSTROUTING ip saddr 10.1.0.0/24 oif eth0 masquerade
        #Destination NAT (port forwarding) with redirect
            nft add rule ip NAT PREROUTING tcp dport 80 redirect to 8080



T1 Exercise Op Notes  (467accfb25050296431008a1357eacb1)
~~~~~~~~~~~~~~~~~~~~
sudo iptables -A INPUT -p tcp -m multiport --ports 22,23,3389 -m state --state NEW,ESTABLISHED -j ACCEPT
sudo iptables -A OUTPUT -p tcp -m multiport --ports 22,23,3389 -m state --state NEW,ESTABLISHED -j ACCEPT

sudo iptables -P INPUT DROP
sudo iptables -P FORWARD DROP
sudo iptables -P OUTPUT DROP

sudo iptables -A INPUT -s 10.10.0.40 -p icmp --icmp-type 8 -j ACCEPT
sudo iptables -A INPUT -d 10.10.0.40 -p icmp --icmp-type 0 -j ACCEPT
sudo iptables -A OUTPUT -s 10.10.0.40 -p icmp --icmp-type 8 -j ACCEPT
sudo iptables -A OUTPUT -d 10.10.0.40 -p icmp --icmp-type 0 -j ACCEPT

sudo iptables -A INPUT -p tcp -m multiport --ports 6579,4444 -j ACCEPT
sudo iptables -A OUTPUT -p tcp -m multiport --ports 6579,4444 -j ACCEPT
sudo iptables -A INPUT -p udp -m multiport --ports 6579,4444 -j ACCEPT
sudo iptables -A OUTPUT -p udp -m multiport --ports 6579,4444 -j ACCEPT

sudo iptables -A INPUT -p tcp --sport 80 -m state --state NEW,ESTABLISHED -j ACCEPT
sudo iptables -A INPUT -p tcp --dport 80 -m state --state NEW,ESTABLISHED -j ACCEPT
sudo iptables -A OUTPUT -p tcp --sport 80 -m state --state NEW,ESTABLISHED -j ACCEPT
sudo iptables -A OUTPUT -p tcp --dport 80 -m state --state NEW,ESTABLISHED -j ACCEPT

T3 Exercise Op Notes   (05e5fb96e2a117e01fc1227f1c4d664c)
~~~~~~~~~~~~~~~~~~~~
sudo iptables -A INPUT -p tcp -m multiport --ports 22,23,3389 -m state --state NEW,ESTABLISHED -j ACCEPT
sudo iptables -A OUTPUT -p tcp -m multiport --ports 22,23,3389 -m state --state NEW,ESTABLISHED -j ACCEPT

sudo iptables -P INPUT DROP
sudo iptables -P FORWARD DROP
sudo iptables -P OUTPUT DROP

sudo iptables -A INPUT -p tcp --sport 80 -m state --state NEW,ESTABLISHED -j ACCEPT
sudo iptables -A INPUT -p tcp --dport 80 -m state --state NEW,ESTABLISHED -j ACCEPT
sudo iptables -A OUTPUT -p tcp --sport 80 -m state --state NEW,ESTABLISHED -j ACCEPT
sudo iptables -A OUTPUT -p tcp --dport 80 -m state --state NEW,ESTABLISHED -j ACCEPT

T2 Exercise Op Notes  (9f7a33941828bdafd2755fd20176cdf4)
~~~~~~~~~~~~~~~~~~~~
sudo nft add table ip CCTC

sudo nft add chain ip CCTC input {type filter hook input priority 0 \; policy accept\;}
sudo nft add chain ip CCTC output {type filter hook output priority 0 \; policy accept\;}

sudo nft add rule ip CCTC input tcp sport { 22,23,3389 } ct state { new,established }
sudo nft add rule ip CCTC input tcp dport { 22,23,3389 } ct state { new,established }
sudo nft add rule ip CCTC output tcp sport { 22,23,3389 } ct state { new,established }
sudo nft add rule ip CCTC output tcp dport { 22,23,3389 } ct state { new,established }

sudo nft add rule ip CCTC input ip saddr 10.10.0.40 icmp type echo-request
sudo nft add rule ip CCTC input ip saddr 10.10.0.40 icmp type echo-reply
sudo nft add rule ip CCTC output ip daddr 10.10.0.40 icmp type echo-request
sudo nft add rule ip CCTC output ip daddr 10.10.0.40 icmp type echo-reply

sudo nft add rule ip CCTC input tcp sport { 5050,5150 }
sudo nft add rule ip CCTC input tcp dport { 5050,5150 }
sudo nft add rule ip CCTC input udp sport { 5050,5150 }
sudo nft add rule ip CCTC input udp dport { 5050,5150 }
sudo nft add rule ip CCTC output tcp sport { 5050,5150 }
sudo nft add rule ip CCTC output tcp dport { 5050,5150 }
sudo nft add rule ip CCTC output udp sport { 5050,5150 }
sudo nft add rule ip CCTC output udp dport { 5050,5150 }

sudo nft add rule ip CCTC input tcp sport { 80 } ct state { new,established }
sudo nft add rule ip CCTC input tcp dport { 80 } ct state { new,established }
sudo nft add rule ip CCTC output tcp sport { 80 } ct state { new,established }
sudo nft add rule ip CCTC output tcp dport { 80 } ct state { new,established }

sudo nft add chain ip CCTC input {type filter hook input priority 0 \; policy drop\;}
sudo nft add chain ip CCTC output {type filter hook input priority 0 \; policy drop\;}

md5 - 953e720e688941b15b72c098022c51c3
validation - d3b88e04de1e76482a1972f36734a7d8


T5 Ecercise Op Notes   (0c2ca80fad4accccce3bcecec1d238ce)
~~~~~~~~~~~~~~~~~~~~
(On T1)
sudo iptables -P FORWARD ACCEPT
sudo iptables -t nat -A POSTROUTING -o eth0 -j SNAT --to 172.16.82.106

T6 Exercise Op Notes  (be33fe60229f8b8ee22931a3820d30ac)
~~~~~~~~~~~~~~~~~~~~
(on t2)
nft add table NAT
sudo nft add table NAT
sudo nft add chain NAT PREROUTING {type nat hook prerouting priority 0 \; }
sudo nft add chain NAT POSTROUTING {type nat hook postrouting priority 0 \; }
sudo nft add rule NAT POSTROUTING ip saddr 192.168.3.30 oif eth0 snat 172.16.82.112

valid - e4f4c65b3884eadf7986adc76caea32c

#Router as  Filter
    #ACL Name and Numbering Conventions
          #ACL Type                               Range/Identifier                          Filters On
          Numbered Standard                       1-99,1300-1999                            Source Address Only
          Numbered Extended                       100-199,2000-2699                         Source Address, Dst Address, Protocol (OPT ICMP type/Code, tcp/udp port)
          Named Standard & Extended               User Created Name                         Same as standard or extended
    
#Intrusion Detection & prevention systems
    #Placement 
        #In-Line
        #or not
    #Recognition Methods
        #Signature
        #Heuristic aka Behavioral
    
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
    
    #General Rule Options
        #msg - specifies the human-readable alert message
        #reference - links to external source of the rule
        #sid - used to uniquely identify Snort rules
        #rev - uniquely identify revisions of Snort rules
        #Classtype - used to describe what a successful attack would do
        #priority - level of concern (1 - really bad, 2 - badish, 3 - informational)
        #metadata - allows a rule writer to embed additional information about the rule
    
    #Payload Detection Options
        #content - looks for a string of text
        #|binary data| - to look for a string of binary HEX
        #nocase - modified content, makes it case insensitive
        #depth - specify how many bytes into a packet Snort should search for the specified pattern
        #distance - how far into a packet Snort should ignore before starting to search for the specified pattern relative to the end of the previous pattern match
        #within - modifier that makes sure that at most N bytes are between pattern matches using the content keyword
        #offset - skips a certain number of bytes before searching (i.e. offset: 12)

    #Non-Payload Detection Options
        #Flow - direction (to/from client and server) and state of connection (established, stateless, stream/no stream)
        #ttl - The ttl keyword is used to check the IP time-to-live value
        #tos - The tos keyword is used to check the IP TOS field for a specific value
        #ipopts - The ipopts keyword is used to check if a specific IP option is present
        #seq - check for a specific TCP sequence number
        #ack - check for a specific TCP acknowledge number
        #flags - The flags keyword is used to check if specific TCP flag bits are present
        #itype - The itype keyword is used to check for a specific ICMP type value
        #icode - The icode keyword is used to check for a specific ICMP code value
        
    #POST Detection Options
        #logto - The logto keyword tells Snort to log all packets that trigger this rule to a special output log file
        #session - The session keyword is built to extract user data from TCP Sessions
        #react - This keyword implements an ability for users to react to traffic that matches a Snort rule by closing connection and sending a notice
        #tag - The tag keyword allow rules to log more than just the single packet that triggered the rule
        #activates - This keyword allows the rule writer to specify a rule to add when a specific network event occurs
        #activated_by - This keyword allows the rule writer to dynamically enable a rule when a specific activate rule is triggered
        #count - Allows the rule writer to specify how many packets to leave the rule enabled for after it is activated

    #Thresholding and Suppressing Options
        type [limit | threshold | both]
            #limit alerts on the 1st event during defined period then ignores the rest
            #Threshold alerts every [x] times during defined period
            #Both alerts once per time internal after seeing [x] amount of occurrences of event. It then ignores all other events during period
        track [by_src | by_dst] #rate is tracked either by source IP address, or destination IP address
        count [num] #number of rule matching in [s] seconds that will cause event_filter limit to be exceeded
        seconds [seconds] #time period over which count is accrued. [s] must be nonzero value

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
    

















