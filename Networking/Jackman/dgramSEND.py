#!/usr/bin/python3

import socket

# This can also be accomplished by using s= socket.socket() due to AF_INET and SOCK_STREAM being default
s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)

ipaddr = '127.0.0.1'
port = 54321

#s.connect((ipaddr, port)) #removed because this is UDP/Dgram which is connection-less

# To send a string as a bytes-like object, add the prefix b to the string. \n is used to go to the next line
s.sendto(b'i\'m mudwalkin in these christians\n', (ipaddr,port)) #dgram uses sendto

# It is recommended that the buffersize used with recvfrom is a power of 2 and not a very large number of bits
response, conn = s.recvfrom(1024)

# In order to receive a message that is sent as a bytes-like-object you must decode into utf-8 (default)
print(response.decode())

#s.close() #removed because DGRAM/UDP is connection-less
