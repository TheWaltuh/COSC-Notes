#!/usr/bin/python3

import socket

# This can also be accomplished by using s= socket.socket() due to AF_INET and SOCK_STREAM being default
s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)

ipaddr = '127.0.0.1'
port = 54321

s.connect((ipaddr, port))

# To send a string as a bytes-like object, add the prefix b to the string. \n is used to go to the next line
s.send(b'Hello is it me you\'re looking for\n')

# It is recommended that the buffersize used with recvfrom is a power of 2 and not a very large number of bits
response, conn = s.recvfrom(1024)

# In order to receive a message that is sent as a bytes-like-object you must decode into utf-8 (default)
print(response.decode())

s.close()
