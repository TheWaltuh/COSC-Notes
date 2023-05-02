#!/bin/bash

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















