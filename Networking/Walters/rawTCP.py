#!/usr/bin/python3
import socket
#for system level commands
import sys
#for extablishing the packet structure, direct access to methods and functions in struct module
from struct import *
#for tcp checksum
import array

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
ip_proto = 6 # sets the ip protocol to 6 (TCP). 6 is TCP, 17 is UDP. In that case additional headers would be needed
ip_check = 0 # The kernel will fill in the checksum
ip_srcadd = socket.inet_aton(src_ip) # inet_aton(string) will convert ip addr into 32 bit binary number
ip_dstadd = socket.inet_aton(dst_ip) # inet_aton(string) will convert an IP to address to a 32 bit binary number

ip_header = pack('!BBHHHBBH4s4s' , ip_ver_ihl, ip_tos, ip_len, ip_id, ip_frag, ip_ttl, ip_proto, ip_check, ip_srcadd, ip_dstadd)
# B - 1 byte
# H - 2 bytes (half word)
# 4s - 4 bytes (full word, converted from string to binary)

#TCP header fields
tcp_src = 54321 # source port
tcp_dst = 777 # destination port
tcp_seq = 454 # sequence number
tcp_ack_seq = 0 #tcp ack seq number
tcp_data_off = 5 # data offset specifying the size of the tcp header * 4 which is 20
tcp_reserve = 0 # 3 reserve bits + ns flag in the reserve field
tcp_flags = 0 # tcp flags field before the bits are turned on
tcp_win = 65535 #maximum allowed window size will be calculated later on
tcp_chk = 0 #tcp checksum which will be calculated later on
tcp_urg_ptr = 0 # urgent pointer only if urg flag is set

#combine the left shifted 4 bit tcp offset and the reserve field.
tcp_off_res = (tcp_data_off << 4) + tcp_reserve

#tcp flags by bit starting from right to left
tcp_fin = 0 #finished
tcp_syn = 1 #sync flag
tcp_rst = 0 #reset flag
tcp_psh = 0 #push flag
tcp_urg = 0 #urgent flag
tcp_ack = 0 #acknowledge flag
tcp_ece = 0 # explicit congestion notification echo
tcp_cwr = 0 # congestion window reduce
#combine the tcp flags by left shifting the bit location and adding the bit together
tcp_flags = tcp_fin + (tcp_syn << 1) + (tcp_rst << 2) + (tcp_psh << 3) + (tcp_ack << 4) + (tcp_urg << 5) + (tcp_ece << 6) + (tcp_cwr << 7)

#the ! inthe pack format string means network order
tcp_hdr = pack('!HHLLBBHHH',tcp_src,tcp_dst,tcp_seq,tcp_ack_seq,tcp_off_res,tcp_flags,tcp_win,tcp_chk,tcp_urg_ptr)
#B = 1 byte
#H = 2 bytes
#L = 4 bytes (long word)


user_data = b'This is the message.'

src_address = socket.inet_aton(src_ip)
dst_address = socket.inet_aton(dst_ip)
reserved = 0
protocol = socket.IPPROTO_TCP
tcp_length = len(tcp_hdr) + len(user_data)

#pack pseudo header and combine with user data
ps_hdr = pack('!4s4sBBH', src_address, dst_address, reserved, protocol, tcp_length)
ps_hdr = ps_hdr + tcp_hdr + user_data

def checksum(data):
    if len(data)%2 != 0:
        data += b'\0'
    res = sum(array.array("H",data))
    res = (res >> 16) + (res & 0xffff)
    res += res >> 16
    return (~res) & 0xffff

tcp_chk = checksum(ps_hdr)

# repack tcp header to fill in correct chechsum. NOT IN NETWORK BYTE ORDER
tcp_hdr = pack('!HHLLBBH', tcp_src, tcp_dst, tcp_seq, tcp_ack_seq, tcp_off_res, tcp_flags, tcp_win) + pack('H',tcp_chk) + pack('!H', tcp_urg_ptr)

#combine all headers and user data!
packet = ip_header + tcp_hdr + user_data

#finally send the packet
s.sendto(packet, (dst_ip,0))
#port 0 is like a wildcard with raw sockets
