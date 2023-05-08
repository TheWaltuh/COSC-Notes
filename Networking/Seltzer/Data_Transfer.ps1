############################################################################################################################################################

                                                       #Data Transfer, Movement, and Redirection#

############################################################################################################################################################

#Data Trasnfer
    #Methods
        #TFTP
          #Trivial File Transfer Protocol
            #RFC 1350 Rev2
            #UDP Transport
            #Extremely small and very simple communication
            #No terminal connection
            #Insecure
            #No Directory services
            #used oftem for tech such as BOOTP and PXE
        #FTP
            #RFC 959
            #TCP Transport
            #uses multiple tcp connections
            #Control Connection (21) / Data Connection (20)
            #Authentication via username and password
                #however still is insecure and data can be extracted if intercepted
            #Two types
              #Active
                  #"get the pizza delivered to you"
                  #not always reliable to allow data into our network when trying touse ftp
              #Passive
                  #Causes to be opened on the server not the client
            #notes
                passive                 #command to swap to passive mode
                help                    #tells all commands you have
                put                     #takes a file and puts in your current directory (moves to the ftp)
                lcd                     #local change directory (move around your box from ftp)
                get                     #gets the file given and brought to your box (takes from the ftp)
                
        #SFTP
          #Secure File Tansfer Protocol
            #TCP Transport via port 22
            #uses symmetric and asymmetric encryption
            #adds FTP like services to ssh
            #Authentication via sign in, or with SSH Key
            #Interactive Terminal access
        #FTPS
          #File Transfer Protocol Secure
            #TCP transport on port 443
            #Adds SSL/TLS encryption to FTP
            #Authentication with username/password and/or PKI
            #Interactive terminal access
            #Teo Modes
                #Explicit
                    #Port 21
                    #request a secure connection
                #Implicit
                    #ports 989/990 (control/data)
                    #is automatically secure
        #SCP
          #Secure Copy Protocol
            #TCP Transprt via port 22
            #uses symmetric and asymmetric encryption
            #Authentication via username/password or with SSH Key
            #Noninteractie
            #Syntax
                scp <src> <dst>
                    -3          #for copying from one remote host to another with the traffic flowing through your machine
                    -P <port>   #for specifying an alternate port
                    -r          #recursive (for directories and shiz)

#Traffic Redirection
    #Netcat
        #is the "swiss army knife"
            #it reads and writes data across network socket connections using TCP
            #reliable back end tool that can be used directly easily driven by other programs and scripts
        #used for the following
            #inbound and outbound connections, TCP/UDP to or from any ports
            #troubleshooting network connections
            #sending/recieving data (insecurely)
            #notes
                nc <ip> <port>
                                -e /bin/bash          #remotely run scrips
                                 < File.txt           #sends file.txt to
                                 > file.txt           #gets file from
            #netcat relay demos
                #used so two boxes that cant see eachother can communicate
                mkfifo <name of pipe>                 #creates a pipe
                nc <standard input ip> <port> < <name of pipe> | nc <standard output ip> <port> 1> <name of pipe>
                nc -lp <port> < infile.txt
                nc -lp <port> > outfile.txt
                
                #$ways to do same thing
                    #changes depending on which is listener
                    #sender is on left
                    #reciever is on right
                nc -lp <port1> 0< mypipe | nc -lp <port2> 1> mypipe
                nc -lp <port1> 0< mypipe | nc HOST_2 <port2> 1> mypipe
                nc Host_1 <port1> 0< mypipe | nc -lp <port2> 1> mypipe
                nc Host_1 <port1> 0< mypipe | nc Host_2 <port2> 1> mypipe
        
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
          #Bsic Syntax
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
                  

        












