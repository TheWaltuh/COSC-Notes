######################################################################################################################################################
                                                                Echo "Linux"
######################################################################################################################################################

#Situational Awareness

hostname, uname -a  #system information
whoami              #the user that you are
w, who              #users logged on
ip a, ifconfig      #get the ip of the machine you're on
ip neigh, arp       #Can get the IPs and MAC addresses of devices that have connected to that machine
ip route, route     
ss (-nt), netstat   #active connections
nft list tables, 
sudo -l             #displays commands that the user has root permissions to
ll                  #long listing and hidden files for ls
top                 #live running processes

#Getting Help

sudo -u <user> <command>      #To run a command as another user
apropos <string>              #Searches for a command where the man page contains the string
file <filename>               #information about a file
wc <filename>                 #Counts the words/lines in a file
which <command>               #gets the filepath of a command


#Linux Filesystem
/bin                #User Command Binarys
/sbin               #System Binarys
/usr/bin            #Specific User/custom Binarys
/boot               #startup processes
/dev                #device files/drivers
/media              #removable device files
/etc                #configuration files
/home               #Each Users home directory
/lib                #Repositorys built into your distro for the system to reference
/mnt                #mounted partitions on the drive
/opt                #A place to put optionally downloaded files
/root               #Root users home directory
/proc               #Files for all the linux processes
/var                #variables, logs are stored here /var/logs /var/spool
 whilst files are containers for data. Everything without exception falls into one of those two cate


