############################################################################################################################################################

                                                                  #Socket Programming#

############################################################################################################################################################
#Python3 Libraries and Refrences
    Socket - https://docs.python.org/3/library/socket.html
    Strut - https://docs.python.org/3/library/struct.html
    Sys - https://docs.python.org/3/library/sys.html
    Errors - https://docs.python.org/3/tutorial/errors.html
    Exceptions - https://docs.python.org/3/library/exceptions.html

#What is a socket
    #communication endpoints
    #Hang out on two ends and wait to hear from the other
    #allow to exhnge information across either the same machine, or a network
    #Need at least two things
        #Port
        #IP
    
#Socket Types
    #Stream Sockets (can associate stream and TCP typically)
        #Connection oriented and sequenced; methods for connection establishment and tear-down. Used with TCP, SCTP, and Bluetooth.
        #user space
    #Datagram Sockets (can associate datagram with UDP typically)
        #Connectionless; designed for quickly sending and receiving data. Used with UDP.
        #user space
    #Raw Sockets (Not specifiy which protocol is being used)
        #Direct sending and receiving of IP packets without automatic protocol-specific formatting.
        #kernel space
            #need sudo to run command

#User Space Applications/Sockets
    #Using tcpdump or wireshark to read a file
    #Using nmap with no switches
    #Using netcat to connect to a listener
    #Using netcat to create a listener above the well known port range(1024+)
    #Using /dev/tcp or /dev/udp to transmit data

#Kernel Space Applications/Sockets
    #Using tcpdump or wireshark to capture packets on the wire
    #Using nmap for OS identification or to set specific flags when scanning
    #Using netcat to create a listener in the well known port range (0 - 1023)
    #Using Scapy to craft or modify a packet for transmission

#Network Programming with python3
    #network sockets primarily use Python3 Socket library and socket.socket function
    import socket
        s = socket.socket(socket.FAMILY, socket.TYPE, socket.PROTOCOL)

#the socket.socket function
    #inside the socket.socket function you have these arguments in order
        socket.socket([*family*[,*type*[*proto*]]])
    #family constants should be
        #AF_INET (default)
        #AF_INET6
        #AF_UNIX
    #type constants should be
        #SOCK_STREAM (default)
        #SOCK_DGRAM
        #SOCK_RAW
    #proto constants should be
        #0 (default)
        #IPPROTO_RAW




