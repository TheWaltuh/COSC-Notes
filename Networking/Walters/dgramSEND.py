#!/usr/bin/python3

import socket

#same as s = socket.socket(), these parameters are the defaults.
s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)

ipaddr = '127.0.0.1'
port = 54321

# remove next line because this is UDP, no need for handshaking
#s.connect((ipaddr, port))

# to send a string as a bytes like object, add prefix 'b to the string'
# \n is used to get a new line
# use .sendto() instead of .send(). Include the tuple of ipaddr,port.
s.sendto(b'Hello is it me you\'re looking for?\n', (ipaddr,port))

# it is recommended that the buffersize used with recvfrom is a power of 2 and not large.
response, conn = s.recvfrom(1024)

#in order to recieve a message that is send as a bytes-like obj, you need to decode it.
print(response.decode())

#don't need close line because DGRAM/UDP is connectionless.
#s.close()
