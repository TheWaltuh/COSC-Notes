###############################################################################################################################################################################

                                                                            #Scanning and Reconnaissance#

###############################################################################################################################################################################

#Inital moves
    #ping sweep to quickly see what networks are alive
        #follow on with a nmap scan to learn about hosts discovered 
    for i in {1..254}; do(ping -c 1 10.50.33.$i | grep "bytes from" &) ;done 
#OSI (Open Source Intelegence)
    #Shit like Google, just using open internet sources to learn about target, or what have you
        #have to take information on internet with a grain of salt
    #DoD def of OSI
        #"produced from publicly available information that is collected, exploited, and disseminated in a timely manner to an appropriate audience for addressing a specific intelligence requirement."

#Documentation
    #need good documentation for when presenting to higher ups
    or
    #for when passing mission onto another marine

#Collection and Use
    #Use mission statement to help dial down what we need and what could be used based on unit or what have you
    #LIMITS
        #we have limits based on what higher ups say on some things we cant do when performing OSI
    #Data to Collect
        #Web Data
            #Cached Content, Analytics, Proxy Web Application, Command Line Interrogation
        #Sensitive Data
            #Business Data, Profiles, Non-Profits/Charities, Business Filings, Historical and Public Listings
        #Publicly Accessible
            #Physical Addresses, Phone Numbers, Email Addresses, User Names, Search Engine Data, Web and Traffic Cameras, Wireless Access Point Data
        #Social Media
            #Twitter, Facebook, Instagram, People Searches, Registry and Wish Lists
            #Use a persons social media to craft phishing schemes to them to try and get em
        #Domain and IP Data
            #DNS Registration, IP Address Assignments, Geolocation Data, Whois

#Hyper-Text Markup Language (HTML)
    #Standard Markup Language for browser interpretation of webpages
     #Client Side interpretation          (web browser)
     #Utilizes elements                   (Identified by tags)
     #Typically redirects to another page for server-side interaction
     #Cascading Stylesheets (CSS) for page themeing

#Scraping Data
    #automating scraping data from web pages
        #can have scripts run programs that can collect basic data 

#Advanced Scanning Techniques (Bread and butter of what we do)
    #Host Discovery
        #Find hosts that are online (ping sweep)
    #Port Enumeration
        #Find ports for each host that is online (nmap)
    #Port Interrogation
        #Find what service is running on each open/avalable port 

#NMAP
    #Used for port discoverny/enumeration
    #Has its own scripting engine
        /usr/share/nmap/scripts
            #dir with thousands of scripts in it
            #will be given ones to use so we dont have to parse all them
            nmap -v -sT -Pn -T4 --script http-robots.txt.nse 10.50.33.251 -p 80
            nmap -v -sT -Pn -T4 --script http-enum.nse 10.50.33.251 -p 80
            nmap -v -sT -Pn -T4 --script discovery 10.50.33.251
            
            sudo apt-get install nikto
            nikto -h <host>
#Robots.txt file
    #file for web pages that contains area not allowed to be scraped by people looking at web pages

















