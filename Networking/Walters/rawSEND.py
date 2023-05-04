#!/usr/bin/python3
import socket
#for system level commands
import sys
#for extablishing the packet structure, direct access to methods and functions in struct module
from struct import *

try:
    s = socket.socket(socket.AF_INET, socket.SOCK_RAW, socket.IPPROTO_RAW)
except socket.error as msg:
    print(msg)
    sys.exit()

packet = ''

src_ip = "10.1.0.2"
dst_ip = "10.3.0.2"

#ipv4 header info
ip_ver_ihl = 69 #decimal conversion of 0x45 for version and IHL length.
ip_tos = 0 # combines dscp and ecn fields
ip_len = 0 # kernel will fill in the actual length of the packet.
ip_id = 12345 # sets the ip id for the packet
ip_frag = 0 # sets fragmentation of off
ip_ttl = 64 # Determines the ttl of the pakcet
ip_proto = 16 # sets the ip protocol to 16 (chaos). 6 is TCP, 17 is UDP. In that case additional headers would be needed
ip_check = 0 # The kernel will fill in the checksum
ip_srcadd = socket.inet_aton(src_ip) # inet_aton(string) will convert ip addr into 32 bit binary number
ip_dstadd = socket.inet_aton(dst_ip) # inet_aton(string) will convert an IP to address to a 32 bit binary number

ip_header = pack('!BBHHHBBH4s4s' , ip_ver_ihl, ip_tos, ip_len, ip_id, ip_frag, ip_ttl, ip_proto, ip_check, ip_srcadd, ip_dstadd)
# B - 1 byte
# H - 2 bytes (half word)
# 4s - 4 bytes (full word, converted from string to binary)

message = b'This is the message.'
packet = ip_header + message

#finally send the packet
s.sendto(packet, (dst_ip,0))
#port 0 is like a wildcard with raw sockets
