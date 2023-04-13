######################################################################################################################################################
                                                                Echo "Linux"
######################################################################################################################################################

#Situational Awareness

hostname, uname -a  #system information
whoami              #the user that you are
w, who              #users logged on
id                  #Gives the id of the current user
ip a, ifconfig      #get the ip of the machine you're on
ip neigh, arp       #Can get the IPs and MAC addresses of devices that have connected to that machine
ip route, route     
ss (-nt), netstat   #active connections
nft list tables, 
sudo -l             #displays commands that the user has root permissions to

#Other Commands
ll                  #long listing and hidden files for ls
top                 #live running processes
xxd <binary file>   #Prints the hexdump/ascii of a binary file

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
echo "Everything in Linux is either a file or a folder"
echo "Root will have a UID of 0"
echo "Every regular user will have a UID in the 1000's"

#Permissions

echo "Basic Permissions"
d r w x r w x r w x

d - filetype (- regular, d directory, l linkfile, b blockfile, p named pipe, c character special, s socket)

r - These 3 permissions are for the objects user/owner
w
x

r - These 3 permissions are for the owning Group
w
x

r - Any other subject
w
x

chmod u=rwx g=rw o=r ./filename
or
chmod 764 ./filename

echo "Advanced Permissions"

find / -perm /1000 2>/dev/null
rwxrwxrwT
#the sticky bit prevents a file from being deleted by users who are not the owner

find / -perm /2000 2>/dev/null
rwxrwsrw-
#the SGID bit forces an executable to rus as the owning group

find / -perm /4000 2>/dev/null
rwsrwxrw-
#the SUID bit forces an executable to rus as the owning user


#String manipulation

echo "REGEX"











