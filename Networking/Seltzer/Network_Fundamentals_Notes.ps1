Credentials - 
##IH (10.50.38.111)
  #student
  #password
#############################################################################################################################################################

                                                              #Networking Fundamentals#

#############################################################################################################################################################
##Basic Commands
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

##Basic Fundamentals
#Binary Identification
  1 = #Bit (basic block)
  4 bits = #Nibble
      #Hex uses Nibbles as single Characters
  8 bits = #Byte/Octet
  16 bits = #Half Word
  32 bits = #Word
  64 bits = #Very Long Word

#Base(n) Formats
  #Common Formats
    Base 2 - 01000010 01100001 01110011 01100101 00100000 00110010
                               (Binary)
    Base 10 - 66 97 115 101 32 49 48
                (Decimal)
    Base 16 - 42 61 73 65 20 31 36
              (Hexadecmal)
    Base 64 - QmFzZSA2NA==
                            #(Image for basic conversion from base 2,10,16)
https://git.cybbh.space/net/public/raw/master/modules/networking/slides/images/Binary_Decimal_Hex.png

#OSI Model Layer 1-4
                              #(OSI Model Graphic)
https://git.cybbh.space/net/public/raw/master/modules/networking/slides/images/OSI.png

    #Physical Layer - Layer 1
          #Responsibilities
              #Hardware Specifications
              #Encoding and Signaling
              #Data Transmission and Reception
              #Physical Network Design

    #Data Link Layer - Layer 2
          #Sub Layers
              #MAC (Media Access Control)
              #LLC (Logical Link Control)
          #Ethernet Header
          https://git.cybbh.space/net/public/raw/master/modules/networking/slides/images/EthernetFramePreamble.png
              First 7 Bytes = Preamble
              Byte 8 = SFD
              Rest of em = Ethernet Frame
          #Type II Frame (64 to 1518 bytes
          https://git.cybbh.space/net/public/raw/master/modules/networking/slides/images/Ethernet_II_Frame.png
              14 Bytes = MAC Header/Trailer
                    First 6 Bytes = Destination MAC
                    Bytes 7 - 12 = Source MAC
                    Bytes 13,14 = Ethertype
                          0x0800 = IPv4
                          0x0806 = ARP
                          0x86DD = IPv6
                          0x8100 = VLAN Tag
              46-1500 Bytes = Data
                    #Payload / Data / SDU
              4 Bytes = CRC/FCS

          #802.1Q Header
          https://git.cybbh.space/net/public/raw/master/modules/networking/slides/images/802.1QFrame.png 
              18 Bytes = MAC Header/Trailer
                    First 6 Bytes = Destination MAC
                    Bytes 7 - 12 = Source MAC
                    Bytes 13-16 = VLAN Tag
                    Bytes 17-18 = EtherType
              46-1500 Bytes = Data
                    #Payload / Data / SDU
              4 Bytes = CRC/FCS
          #ARP Header
          https://git.cybbh.space/net/public/raw/master/modules/networking/slides/images/ARP_Header.png

    #Network Layer - Layer 3
          #IPv4 Headers
          https://git.cybbh.space/net/public/raw/master/modules/networking/slides/images/IPv4_Header.png
              #All Offsets begin with 0 
                    #DO NOT FORGET ABOUT 0 IT COUNTS
          
          #Fragmentation Process
          https://git.cybbh.space/net/public/raw/master/modules/networking/slides/images/Fragmentation.png
              #Will continue to fragment as long as the more fragment flag is on
              #typically frags in 1480 bit (or byte need to see) fragments
              
          #IPv6 Headers
          https://git.cybbh.space/net/public/raw/master/modules/networking/slides/images/IPv6_Header.png
              #has its own fragmentation deal
                  #Got rid of all things in header related to fragmentation
                  #Now is flow label (does the fragmentaion shit)
              #larger than IPv4
                  #Source and Dest IP address are much larger than in IPv4
              #TTL became Hop Limit
              #Next Header tells you what comes after
          https://git.cybbh.space/net/public/raw/master/modules/networking/slides/images/IPv4_vs_IPv6_Header.png
                          #Compairison of IPv4 and IPv6
          
          #Fingerprinting
              #Vendors have chosen different TTL values for their stuff
                  #Can use TTL to identify OS Family the generated packet is from
              #TTL List
                  64  = Linux (Kernel 2.4 and 2.6)
                  64  = Googles's customized Linus
                  64  = FreeBSD
                  128 = Windows XP
                  128 = Windows 7, Vista and Server 2008
                  225 = Cisco Router (IOS 12.4)
          
          #ICMP Header
          https://git.cybbh.space/net/public/raw/master/modules/networking/slides/images/ICMPHeader.png
          
          #Zero Configuration
              #Used to remotely boot and isntall an Operating System just by plugging inthe computer and starting it up
            #IPv4
                #APIPA
                #RFC 3927
            #IPv6
                #SLAAC (Stateless Address Auto-Configuration)
                #RFC 4862
                
    #Spanning Tree Protocol (STP)
    https://git.cybbh.space/net/public/raw/master/modules/networking/slides/images/Spanning-Tree-Protocol-Overview.png
                     Root decision process

        1. Elect root Bridge

        2. Identify the Root ports on non-root bridge

        3. Identify the Designated port for each segment

        4. Set alternate ports to blocking state

    #Layer 2 Discovery Protocols
        #Cisco Discovery Protocol (CDP)
        #Foundry Discovery Protocol (FDP)
        #Link Layer Discovery Protocol(LLDP)

    #Dynamic Trunking Protocol
    https://git.cybbh.space/net/public/raw/master/modules/networking/slides/images/DTP_Chart.png
        #Automatically sends over all packtets and splits and sends to correct vlan after sent across
                #Less wasted ports
    
    #Vlan Trunking Protocol
    https://git.cybbh.space/net/public/raw/master/modules/networking/slides/images/VTP.png
        #Way to send vlans from switch to switch
        #Server / Client relationship
              #Configure once then all else copy it
              #Based off of Version numbers
                  #Highest num wins
              
    #Port Security
        #If sees a packet coming from a given MAC address does one of following modes
        #Modes
           - Shutdown
                #(perm closes down port)
           - Restrict
                #(not perm close)
           - Protect
                #(lets connect but logs what happens)

    #Layer 3 Routing Technologies 
        #Routing
        https://git.cybbh.space/net/public/raw/master/modules/networking/slides/images/ip_routing_example.jpg
            #Works off of a Routing table
                #Table full of netowkrs associated to ports
                #same system different layer than layer 2
        #Anatomy
        https://git.cybbh.space/net/public/raw/master/modules/networking/slides/images/Route_Types.png
        
        #Lookup Process
        https://git.cybbh.space/net/public/raw/master/modules/networking/slides/images/Bit_Match.jpg
            #Find whoever has the biggest match (Longest to IP Packet Destination)
                  #Longer the match higher the priotity 
        #Routed Vs Routing
            #Routing Protocols
                #Used between layer 3 devices to learn and advertise Routers and maintain routing tables
                #Routing Protocol Routes a Routed protocol for learning and maintaining the routing table
                #Examples include RIP, EGRIP, OSPF BGP,  etc.
            #Routed Protocols
                #used between Routers to direct user traffic.  Is also called netowrk protocols
                #Routed protocols are rouded by using Routing Protocols
                #Examples include IP, IPX, AppleTalk, NetWare, etc.
        
        #First Hop Redundancy Protocols
        https://git.cybbh.space/net/public/raw/master/modules/networking/slides/images/FHRP.jpg
        
        #Administrative Distance
        https://git.cybbh.space/net/public/raw/master/modules/networking/slides/images/AD.png
            #Lower the distance the better (higher priority)

        #Metrics
            #Used to evaluate performance and reliability of a computer network
            - Hop
            - Bandwidth
            - Delay
            - Load
            - MTU
            - Reliability
            - Cost
            - Policy
        #Static Routing Advantages and Disadvantages
        https://git.cybbh.space/net/public/raw/master/modules/networking/slides/images/staticAD.png
        
        #Dynamic Routing
        https://git.cybbh.space/net/public/raw/master/modules/networking/slides/images/Dynamic_Routing.jpg
            #Replaced Static Routing
                #Much Easier for us, don't have to go in manually
            #IGP (Interor Gateway Protocol)
                #Used to Talk inside a network
            #EGP (Exteror Gateway Protocol)
                #Used for netowkrs to talk to eachother

        #Dynamic Routing Advantages and Disadvantages
        https://git.cybbh.space/net/public/raw/master/modules/networking/slides/images/dynamicAD.png

        #Controling Entities
                                                                IANA
                                                                  |
                                            ---------------------------------------------
                                            |          |          |           |         |
                                            v          v          v           v         v
                                         LACNIC      ARIN      RIPENCC     AFRINIC    APNIC
            #LACNIC
              #Latin AMerica
              #NIC (Mexico)
              #NIC (Brazil)
            #ARIN
              #North America
            #RIPENCC
              #Eurasia/Middle East
            #AFRINIC
              #Africa
            #APNIC
              #Asia/Pacific
              #APJII (Indonesia)
              #KRNIC (Korea)
              #CNNIC (China)
              #TWNIC (Taiwan)
              #JPNIC (Japan)
              #VNNIC (Vietnam)
              
        #Border Gateway Protocol (BGP)
            #Road-Map of the Internet
            #Routes traffic between Autonomous System (AS) Number
            #Advertises IP CIDR address blocks
            #Establishes Peer relationships
            #Complicated configuration
            #Complicated and slow path selection
            
      #BGP Hijacking
          #Illegitimate advertising of addresses
          #BGP propagates false information
          #Purpose:
            #stealing prefixes
            #monitoring traffic
            #intercept (and possibly modify) Internet traffic
            #'black holing' traffic
            #perform MitM
      









