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














