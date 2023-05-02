#!/bin/bash
MEMORIZE THE WELL KNOWN RANGES/EHEMERI HIGH PORT RANGES
DSCP bit shift:
  multiply DSCP+ECN value by 4 if ecn is 0 othewise subtract ECN

Layer 4 - TRANSPORT LAYER
  TCP
    connection oriented (3-way handshake)
      
      syn 0x02 -> 
      <- syn-ack 0x12 
      ack 0x1 ->
      established
      
      fin-ack 0x11 ->
      <- ack 0x1
      <- fin-ack 0x11
      ack 0x1 ->
      closed
      
      0x00 null
      0xFF or 0x3F XMAS
      
    can reorder packets to be correct
  UDP
    connectionless/unreliable
    fire & forget
Layer 5 - SESSION LAYER
  all L5 protocols use TCP
  SMB TCP 139/445 UDP 137/138
  PPTP/L2TP/L2F/SSTP/OpenVPN/IPSec
  RPC
    NFS (remote system calls for network attatched storage)
    Remoting
Layer 6 - PRESENTATION LAYER
  Responsible for translation (encoding/encryption/compression)
Layer 7 - Application Layer
  Specific application data
  FTP
    active - client issues port/ip for transfer (port 20 to see the file)
    passive - client asks the server to issue port/ip (RHN port to see the file) 1stNum * 256 + 2ndNum
  SSH
    server/client
    
  TELNET
    TCP 23, unsecure remote connection
  SMTP
    TCP 25, send mail between mail servers
  POP
    TCP 110
  IMAP
    TCP 143
  TACACS
    TCP 49, authentication
  RADIUS
    UDP 1645/1646/1812/1813
  HTTP(S)
    TCP 80/443
    messages get/head/post/put
    status 100,200,300,400
  RDP
    TCP 3389, remote desktop
  DNS
    QUERY UDP 53
    RESPONSE UDP 53
    ZONE TRANSFER TCP 53
  DHCP
    UDP 67/68
      Discover Offer Request Accept DORA ~(DHCP)
      Solicit Advertise Request Reply ~(DHCPv6)
  TFTP
    UDP 69
  NTP
    UDP 123
  SNMP 
    UDP 161/162
    going to 161 going to client (from manager)
    going to 162 going to server (from agent)
    Get Request, Set Request Get Next, Get Bulk, Response, Trap, Inform
  RTP
    UDP above 1023








