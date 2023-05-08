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
        #SFTP
            #TCP Transport via port 22
            #uses symmetric and asymmetric encryption
            #adds FTP like services to ssh
            #Authentication via sign in, or with SSH Key
            #Interactive Terminal access
        #SCP
            #













