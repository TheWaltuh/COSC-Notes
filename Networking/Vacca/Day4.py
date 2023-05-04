'''
#########################################################
                  Network Programming
#########################################################
  User Space Sockets:
    Stream Sockets- Connection Oriented/Sequenced, TCP/SCTP,Bluetooth
    Datagram Sockets- Connectionless, UDP
    Some examples: tcpdump/wireshark to read a file, nmap with no switches, connecting to a nc listener or creating a 1024+ listener, /dev/tcp or /dev/udp
  Kernel Space Sockets:
    Raw Sockets- Directly Sending with no protocol-specific formatting
    Some Examples: tcpdump/wireshark capture on the wire, specific nmap flags, creating a listener on a well known port, scapy or python packet modification or transmission
'''

import socket

s = socket.socket(socket.FAMILY, socket.TYPE, socket.PROTOCOL)
'''
Family:
  AF_INET, AF_INET6
Type:
  SOCK_STREAM, SOCK_DGRAM, SOCK_RAW
Protocol:
  IPPROTO_RAW
'''
#https://docs.python.org/3/library/socket.html
#https://docs.python.org/3/library/struct.html
#https://docs.python.org/3/library/sys.html
#https://docs.python.org/3/tutorial/errors.html
#https://docs.python.org/3/library/exceptions.html













