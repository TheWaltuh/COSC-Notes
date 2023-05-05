############################################################################################################################################################

                                                               #Network Reconnaissance#

############################################################################################################################################################

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
      #Local to Remote
      #Local to Local
      #Remote to Remote










