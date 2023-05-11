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

#Network Data Types
    #Full Packet Capture Data
    #Session Data
        #sflow
        #NetFlow
    #Statistical Data
    #Packet String Data
    #Alert Data
    #Log Data
    #Data Collection Devices
        #Sensors
            #In-Line
                #like a MITM type thing
                Pros:
                  #Can cause dropping of sus packets
                Cons:
                  #if sensor goes down, whole network can go down
                  #Is visible (shows up as hop)
            #Passive
                #Where you just copy data and send out another line
                #Invisible from enmey perspective
                #Does not impact network
    #Data Collection Methods
        #TAPS
            #Like the spy movie shit with tapping phone lines, etc
        #SPAN
            #no additional hardware needed
        #ARP Spoofing (MITM)
            #make data go through your device and then copy it

#Anaomaly detection
    #Indicator of Attack (IOA)
        #Proactive
        #a series of actions that are suspicous together
        #Focus of intent
        #looks for what must happen
            #code execution, persistance, lateral movement, etc.
    #Indicator of Compromise (IOC)
        #Reactive
        #forensic evidence
        #Provides information that canchange
            #Malware, ip addresses, exploits, signatures
#Indicators
    #.exe/executable files
    #NOP sled
        #No Operation = NOP
    #Repeated Letters
    #Well Known Signatures
    #Mismatched Protocols
    #Unusual traffic
    #Large amounts of traffic/ unusual times
    















