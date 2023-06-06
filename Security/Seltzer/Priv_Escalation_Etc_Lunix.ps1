####################################################################################################################################################################################################

#

#######################################################################################################################################################################################################

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
    
