#!/bin/bash

OSI Model

Layer 1 - Physical
  The actual physical devices and mediums
Layer 2 - Data Link
  Logical information about the information called a frame
  A frame will have a: DestMac,SrcMac,Ethertype
  EtherType:
    0x0800 IPv4
    0x0806 Arp
      requests and replys
      stp is to prevent a broadcast storm
    0x86DD  IPv6
    0x8100  VLAN tag
      extra bits in the header
  Switches
    Ports can be seperated into VLANS
    switches can connect vlans to eachother with a trunk
    ports can be shutdown, restrict, or protect
Layer 3 - Network
  IPv4
    Fragmentation Formula: (MTU - (IHL * 4) / 8) = offset
  IPv6
  ICMP
  Routers
    Routers have routing tables
Layer 4 - Transport
  TCP
  UDP

