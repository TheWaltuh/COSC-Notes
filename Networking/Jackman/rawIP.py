#!/usr/bin/python3

# For building the socket
import socket

# For system level commands
import sys

# For establishing the packet structure (used later on), this will allow direct access to the methods and functions in the struct module
from struct import *

# Create a raw socket
try: 
    s = socket.socket(socket.AF_INET, socket.SOCK_RAW, socket.IPPROTO_RAW)
except socket.error as msg:
    print(msg)
    sys.ext()

packet = ''

src_ip = "10.1.0.2"
dst_ip = "10.3.0.2"

# Lets add the IPv4 header information
ip_ver_ihl = 69 # This is putting the decimal conversion 0x45 for Version and Internet Header Length
ip_tos = 0      # This combines the DSCP and ECN fields
ip_len = 0      # The kernel will fill in the actual length of the packet
ip_id = 12345   # This sets the Ip identification for the packet
ip_frag = 0     # This sets fragmentation to off
ip_ttl = 64     # This determines the TTL of the pcket when leaving the machine
ip_proto = 16   # This sets the IP protocol to 16 (Chaos). If this was 6 (TCP) or 17 (UDP) additional headers would be required
ip_check = 0    # The kernel will fill in the checksum for the packet
ip_srcadd = socket.inet_aton(src_ip)  # inet_anton(string) will convert an IP address to a 32 bit binary number
ip_dstadd = socket.inet_aton(dst_ip)  # inet_anton(string) will convert an Ip address to a 32 bit binary number

ip_header = pack('!BBHHHBBH4s4s' , ip_ver_ihl, ip_tos, ip_len, ip_id, ip_frag, ip_ttl, ip_proto, ip_check, ip_srcadd, ip_dstadd)
# B - 1 byte (Byte)
# H - 2 bytes (Half Word)
#4s - 4 bytes (Word - converted from string to binary)

message = b'The bird is the word'
packet = ip_header + message

# Send the packet
s.sendto(packet, (dst_ip, 0))
