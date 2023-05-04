#!/usr/bin/python3

import socket

#same as s = socket.socket(), these parameters are the defaults.
s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)

ipaddr = '127.0.0.1'
port = 54321

s.connect((ipaddr, port))

# to send a string as a bytes like object, add prefix 'b to the string'
# \n is used to get a new line
s.send(b'Hello is it me you\'re looking for?\n')

# it is recommended that the buffersize used with recvfrom is a power of 2 and not large.
response, conn = s.recvfrom(1024)

#in order to recieve a message that is send as a bytes-like obj, you need to decode it.
print(response.decode())

s.close()
