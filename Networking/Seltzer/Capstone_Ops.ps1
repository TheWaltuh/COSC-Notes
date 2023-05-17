#######################################################################################################################################################################################################

                                                                                                #Capstone#

#######################################################################################################################################################################################################

##BPF I used and what for
Using BPF’s, determine how many packets with a DSCP of 26 being sent to the host 10.0.0.103.
    tcpdump 'ip[1]>>2=26&&ip[16:4]=0x0a000067' -r /usr/share/cctc/capstone-bpf.pcap | wc -l
                (ip 1 for dscp)     (dst addr = ip[16:4} = hex of ip)
                (>>2 to not have last two bits that arent dscp)

What is the total number of fragmented packets?
    tcpdump '((ip[6:2] > 0) && (not ip[6] = 64))' -r /usr/share/cctc/capstone-bpf.pcap | wc -l

How many packets have the DF flag set and has ONLY the RST and FIN TCP Flags set?
    tcpdump 'ip[6]&64=64 && tcp[13]=0x05' -r /usr/share/cctc/capstone-bpf.pcap | wc -l
              (need &64=64 not just =64)
              (0x05 is the FIN RST flag)

An attacker is targeting the host 10.0.0.104 with either a TCP full or half open scan. Based off the pcap, how many ports are open?
    tcpdump 'tcp[13]=0x12 && ip[12:4]=0x0a000068' -r /usr/share/cctc/capstone-bpf.pcap | wc -l

When a machine is being attacked via a port use tcpdump to scan and see attack happening
    tcpdump -i <interface> -X 'tcp[2:2]=<port>'

sudo iptables -t mangle -A POSTROUTING -j TTL --ttl-set 254       #how to cange ttl to match a typical cisco device

Tunnels
~~~~~~~
ssh -p 7777 net3_student15@10.50.24.41 -L 31500:10.2.2.7:23 -NT

ssh -p 7777 net3_student15@10.2.2.6 -R 31501:localhost:2222 -NT
ssh -p 7777 net3_student15@10.50.24.41 -L 31502:localhost:31501 -NT

ssh net3_student15@localhost -p 31502 -L 31503:10.10.10.140:301 -NT
ssh net3_student15@localhost -p 31502 -L 31504:10.10.10.167:404 -NT
