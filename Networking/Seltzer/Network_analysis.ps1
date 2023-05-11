###################################################################################################################################################################################################

                                                                                        #Network Analysis#

###################################################################################################################################################################################################

#Fingerprinting and Host identification
    #Variances in the RFC implementation for different OS’s and systems enables the capability for fingerprinting
    #Tools used for fingerprinting and host identification can be used passively(sniffing/fingerprinting) or actively(scanning)
#Passive OS Fingerprinting
    #Looks at Variations in initial TTL, Fragmentation flag, default ip header packet length, window size, and tcp options
    #config stored in
        /etc/p0f/p0f.fp
    #syntax
        sudo p0f -r <pcap>

#Network traffic Sniffing
    #what makes traffic capture possible (what wireshark/tcpdump use)
        - Libpcap
        - WinPcap (outdated)
        - NPCAP
    #Network Traffic Baselining
        #is not live, but is a snapshot so time of day can change whats shown
        #no industry standard
        #7 days is typical amount of time to get initial snapshot
        #Prerequisite information
        #Objective:
            #Determines the current state of your network
            #Acertain the current utilization of network resouces
            #Identify normal vs peak network traffic time frames
            #verify port / protocol usage
    #Big Picture things to check
        #Protocol Hierarchy
        #Conversations
        #Endpoints
        #I/O Graph
        #IPv4 and IPv6 Statistics
        #Expert Information



















