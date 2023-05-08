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













