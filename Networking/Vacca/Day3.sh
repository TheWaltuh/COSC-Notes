#!/bin/bash

#################################################################
                   'Network Traffic Sniffing'
#################################################################
#tcpdump with Berkley Packet Filtering (BPF)
use sudo:
tcpdump -D      #list network interfaces
        -i      #specify interface
        -X      #hex and ascii
        -XX     #hex and ascii including ethernet header
        -w      #writes output to a file
        -vv     #more info
        -r      #reads from pcap
        port <> -vn     #v is verbose n disables name resolution (shows ips)
        src port <port>
        dst port <port>
        portrange <port-port>
        host <ip>
        src host <ip>
        dst host <ip>
        net <ip/cidr>
        src net <ip/cidr>
        dst net <ip/cidr>
bools: && AND || OR 
example:  sudo tcpdump "(src net 10.1.0.0/24 && (dst net 10.3.0.0/24 || dst host 10.2.0.3) && (! dst host 10.1.0.3))" -vn

Value  Flag Type 	Description
S 	   SYN 	      Connection Start
F 	   FIN 	      Connection Finish
P      PUSH       Data push
R 	   RST 	      Connection reset
.      ACK 	      Acknowledgment


Berkley Packet Filters

tcpdump {A} [B:C] {D} {E} {F} {G}
A = Protocol (ether | arp | ip | ip6 | icmp | tcp | udp)
B = Header Byte offset [starting byte:byte length]
C = optional: Byte Length. Can be 1, 2 or 4 (default 1)
D = optional: Bitwise mask (&)
E = Operator (= | == | > | < | <= | >= | != | () | << | >>)
F = Result of Expression
G = optional: Logical Operator (&& ||) to bridge expressions

examlpe: tcpdump 'ether[12:2] = 0x0800 && (tcp[2:2] != 22 && tcp[2:2] !=23)'

Bitwise Masking

tcpdump <protocol>[<offset>] & 0x<bits to match> <operator> <value>
txpdump ip[0] & 0x0F > 0x05

tcpdump tcp[13] = 0x11        #must have only those bits on
--sameas--
tcpdump tcp[13] & 0xFF = 0x11

tcpdump tcp[13] & 0x11 = 0x11 #those bits bust be set but the others can be whatever

tcpdump tcp[13] & 0x11 !=0    #atleat 1 must be turned on





