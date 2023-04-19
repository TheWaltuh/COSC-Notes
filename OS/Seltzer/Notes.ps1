Stack Number - 20
admin server - 10.50.35.99

############################################################################################################################################################

                                                                      #Day 1#

############################################################################################################################################################


##Powershell Commands
get-host                            #gets overall information about system

get-host | select-object version    #gets specifically the version
(get-host).version                  #another way to get version

pwsh                                #opens a new version of powershell in command line
      exit                          #gets out of new version

#process is an atribute of an object
#member is an action that can be done to said object..


get-cimclass                        #gets a list of the cim classes in a specific object

get-ciminstance -classname Win32_LogicalDisk -filter "DriveType=3"          #displays only disk information from the local machine that is drive type of 3
get-wmiobject -class Win32_logicalDisk -filter "DroveType=3"                #same as above (this way older commands, cim is new way getting pushed)

get-ciminstance -class Win32_Bios   #gets all Bios information from machine

get-ciminstance -classname Win32_Product -filter 'name like"microsoft%"'  #gets all infor from Win32_Product 
                                                                          #and then filters showing only those which name beginning with microsoft

get-executionpolicy                 #gets the execution polocies for the current session
get-executionpolicy -list           #same as above just in list format

start-transcript                    #record everything you type/track commands run

##basic loop revirew (see old notes for more details)
do {<statement list>} while (<condition>)
do {<statement list>} until (<condition>)

for (<init>;<condition>;<repeat>)
while(<condition>){<Statement list>}

#basic variable review
$var=34       #establishes a variable with a int value (can obvusly do other data types as well)

get-variable  #gets environmental variables

get-localuser #gets local user accounts

###powershell profiles (load from bottom up)
#Current User, Current Host
#Current User, All Host
#All Users, Current Host
#All Users, all host

#EVERYTIME POWERSHELL IS LOADED PROFILES ARE READ
#WAY THAT ENEMY CAN ESTABLISH PERSISTANCE

##ISE profiles
#Current User, Current Host
#All Users, Current Host

$PsHome         #Stores the installation directory for PowerShell
$Home           #Stores the current user’s home directory
$profile        #variable stores the paths to the PowerShell profiles that are available in the current session

$profile | Get-Member -Type NoteProperty                        # Displays the profile values of Names, MemberType, and Paths
$Profile | get-member -type noteproperty | ft -wrap             # Displays the same results but completed in case it was cut off '...'
$PROFILE | Get-Member -MemberType noteproperty | select name    # Narrowed results to display only Names

##how to test paths to see if they exist(show if user has been created)
Test-Path -Path $profile.currentUsercurrentHost
Test-Path -Path $profile.currentUserAllHosts
Test-Path -Path $profile.AllUsersAllHosts
Test-Path -Path $profile.AllUserscurrentHost

New-Item -ItemType File -Path $profile -Force                 # Creates a $Profile for the CurrentUser. Force is used to ignore any errors
New-Alias -Name DemUsers -Value Get-LocalUser                 #saves alias to profile so it is not wiped with closing of powershell


##basic function rev
function Color-Console {
  $Host.ui.rawui.backgroundcolor = "black"
  $Host.ui.rawui.foregroundcolor = "green"
  $hosttime = (Get-ChildItem -Path $PSHOME\PowerShell.exe).CreationTime
  $hostversion="$($Host.Version.Major)`.$($Host.Version.Minor)"
  $Host.UI.RawUI.WindowTitle = "PowerShell $hostversion ($hosttime)"
  Clear-Host
}
Color-Console
          #changes your color in powershell

###Namespaces
[NameSpace.Class]::Method()         #basic syntax to invoke a namespace

###Downlaod a file with powershell
$url = "http://downloads.volatilityfoundation.org/releases/2.6/volatility_2.6_win64_standalone.zip"
$output = "$PSScriptRoot\volatility_2.6_win64_standalone.zip"
$start_time = Get-Date
        #establishes variables to use for download url for where from, output for where too, start time holds get date
        
$wc = New-Object System.Net.WebClient 
$wc.DownloadFile($url, $output) 


(New-Object System.Net.WebClient).DownloadFile($url, $output)



(1000..1) | % {Expand-Archive .\Omega$_.zip -force -DestinationPath C:\Users\CTF\Documents\ }     #iterates through zip files names omega1000 to omega1
                                                                                                  #unzips them all, and then 

#########################################################################################################################################################

                                                                      #Day 2#

#########################################################################################################################################################

##Windows Regestry 
#regestry is a heirercial database containing info about the entire system (like a roladex)

#cat /etc/profile (way to check for persistance on device)

##Tools for regestry editing/working
regedit.exe
    #gui
    #located at "C:\Windows\regedit.exe"

reg.exe
   #CLI
   #located at "C:\Windows\System32\reg.exe"
   #minimum commands to know
        reg add, reg query, reg delete


##Five Hives
HKCR
  #Classes Root
  #
HKCU
  #Current User
HKLM
  #Local Machine (has information about Windows services, drivers, programs that automatically run for every user, and general OS settings, etc)
HKU
  #Users 
    #S-1-5-18 refers to LocalSystem account
    #S-1-5-19 refers to LocalService account
    #S-1-5-20 refers to NetworkService account
    #S-1-5-21-domain-500 Refers to the built in local administrator account
HKCC
  #Current Config

##Registry Value Types
REG_BINARY                    #Binary data in any form
REG_DWORD                     #A 32-bit number
REG_DWORD_LITTLE_ENDIAN       #A 32-bit number in little-endian format
REG_DWORD_BIG_ENDIAN          #A 32-bit number in big-endian format
REG_EXPAND_SZ                 #A null-terminated string that contains unexpanded references to environment variables
REG_LINK                      #A null-terminated Unicode string that contains the target path of a symbolic link that was created by calling the RegCreateKeyEx function with REG_OPTION_CREATE_LINK
REG_MULTI_SZ                  #A sequence of null-terminated strings, terminated by an empty string
REG_NONE                      #No defined value type
REG_QWORD                     #A 64-bit number
REG_QWORD_LITTLE_ENDIAN       #A 64-bit number in little-endian format
REG_SZ                        #A null-terminated string.

##reg.exe

#query the local machine 
reg.exe query HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run

#output
HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Run
    SecurityHealth    REG_EXPAND_SZ    %windir%\system32\SecurityHealthSystray.exe


##commands
get-localuser | select name, sid                        #outputs names and sids for all local users (PS)

##Querying Registery
  Get-ChildItem                           #cmdlet gets the items in one or more specified locations.
  get-childitem HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion
          #cant have run on the end
          #read subkeys
          
  Get-ItemProperty                        #cmdlet gets the items in one or more specified locations.

  Get-Item                                #cmdlet gets the item at the specified location. It doesn’t get the contents of the item at the location unless you use a wildcard character (*) to request all the contents of the item
  get-item HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Run
          #use this to see if enemy has established persistance on your device
          #look for suspicious applications (shit like Hogwarts Legacy kinds deal)
          #read key values
##Modify Registry

Set-ItemProperty                          #cmdlet changes the value of the property of the specified item. example, changing setting to :true or :false.

Remove-ItemProperty                       #cmdlet to delete registry values and the data that they store.

##Create Items in the Registry

New-Item                                  #cmdlet creates a new item and sets its value. In the registry, New-Item creates registry keys and entries.

New-Itemproperty                          #cmdlet creates a new property for a specified item and sets its value. Typically, this cmdlet is used to create new registry values, because registry values are properties of a registry key item.

##PSDrives
#is a data store location that you can access like a file system drive in Windows PowerShell
#exclusive to powershell

get-psdrive           #lists all currently installed psdrives
                      #shows name, space used, free space, provider, and the path to the root of the psdrive

new-psdrive -name FileServer -PSProvider Filesystem -Root "\\file-server\warrior share"
                      #creates a new psdrive with a name of FileServer, provider of filesystem, and a root path of \fileserver\warrior share
                      #useful for exercises
                      
Get-ChildItem Env:    #shows all environmental variables in ENV: drive

##Alternate Data Streams (ADS)
#built into windows
#cannot disable it
#windows defender typically stops someone from using it
#not super common but possible
#adding/editing with ads does not change any part of the original file except the last modified date
#hash does not change with alternate data streams

#Basic syntax of a PSPath
[filename.extension]:[alternate_stream_name]::$DATA

Set-Content .\coffee.txt -Value "Horns sicual security number is 123-45-6789" -stream secret.info
                                              #adds a alternate data stream to coffee.txt

Get-Item .\coffee.txt -Stream *
            #shows streams of coffee.txt (how to view alternate data streams)
            
get-item <what checking for ads> -stream * | select-object pspath       #show only the path so easy to see if ads or not
                                                                        #if not $DATA then is ADS

Get-Content .\coffee.txt -Stream secret.info
            #shows whats inside the alternate data stream of secret.info

get-item 'REGISTRY::HKEY_USERS\*\SOFTWARE\microsoft\windows\currentversion\run'           #shows contents of all users key that runs on each login

Get-ChildItem 'HKLM:\Software\microsoft\Windows NT\Currentversion\ProfileList'            #shows profiles on device so can look for sus one

Get-ChildItem 'HKLM:\Software\microsoft\Windows NT\Currentversion\NetworkList\Profiles'   #shows network profiles to see if any sus network connections

get-filehash -algorithm <Parameter>                                                       #show the <parameter> filehash of a file

get-acl                                                                                   #list permissions of a file

 Get-Content <hidden file name> -Stream Hidden                                            #read contents of a hidden document
 

##########################################################################################################################################################

                                                                      #Day 3#

##########################################################################################################################################################

###


###Linux Commands

!!                          #allows to reuse last run command

pwd                         #print working directory

hostname                    #displays the name of the host you are currently on.
uname -a                    #displays the name of the host you are currently on.

whoami                      #shows the user you are currently logged in as (useful after gaining access through service exploitation)
w                           #shows the user you are currently logged in as (useful after gaining access through service exploitation)
id                          #gives your user,group ids and groups

who                         #shows who else is logged in.

ip addr                     #displays network interfaces and configured IP addresses
ifconfig                    #displays network interfaces and configured IP addresses

ip neigh                    #displays MAC addresses of devices observed on the network
arp                         #displays MAC addresses of devices observed on the network

ip route                    #shows where packets will be routed for a particular destination address
route                       #shows where packets will be routed for a particular destination address

ss -ntlp                    #will show network connections or listening ports
netstat                     #will show network connections or listening ports

nft list tables             #to view firewall rules
iptables -L                 #to view firewall rules

sudo -l                     #displays commands the user may run with elevated permissions (envolking command as root user)
sudo -u <user to run as>    #runs commands as another user

lsblk                       #listing block devices

apropos <search term>       #look up commands that involve search term

file                        #determine type of files

wc -l                       #returns a count of number of lines in specifies area

which                       #gives full path to files or directorys given
          which passwd      #/usr/bin/passwd

ll                          #by default gives long listing and shows hidden files (better than ls)

top                         #live version on ps command

xxd <binary file>           #how to read a binary file (dont use cat)

chmod                       #changer permissions of a file or dir
                            
chown                       #changes ownership of a file or dir

find -

openssl enc -d <key> <cipher> #enc for encrypted and -d is decrypt

find <path to search> -user <username> -perm /u+w             #searches a given dir for the file that given user is the only one to permission to write
                                                              #/u makes so only user
cat numbers | egrep '^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$' | wc -l      #returns a count of ip address like numbers in the file numbers
                                                                                    #^ means it needs to start with and $ means it needs to end with


##string manipulation commands
grep                        #used to search for given data
egrep                       #same as grep -E

awk                         #Find and Replace text

sed



##Files included in linux
/usr/bin                    #contains the path to all commands and such
/bin                        #same as /usr/bin but for single user mode
/sbin                       #contains binarys only accessable to root user
/boot                       #contains boot process
/dev                        #contains device files
/etc                        #has everything configurable 
/etc/group                  #contains all group information
/etc/passwd                 #has username, ids, password shit and default shell, etc
/home                       #all users home directories will be here
/lib                        #local repositories linux uses to pull information on itself
/mnt                        #mounted partirons on the drive
/opt                        #contains optional programs (add on instilations adn software packages)
/root                       #roots home directory
/proc                       #contains all linux process ids
/var                        #contains variables (important in here is 
/var/logs                   #contains default logs
/var/spool                  #like a roll of tasks that need to be done (useful for ctfd)

##Special permissions
#sticky bit makes it so only the user who owns the file can delete it
#identified by an s in the last set of the user permissions


##HOW TO PRINT A RANGE OF LINE NUMBERS USING AWK
$ cat filename | awk 'NR==M, NR==N'

###REGEX
/[\d]{3}-\[d]{2}-\[d]{4}/g        #regex to find social security numbers

^(25[0-5]|2[0-4][0-9]|[01]?[0-9]?[0-9])\.(25[0-5]|2[0-4][0-9]|[01]?[0-9]?[0-9])\.(25[0-5]|2[0-4][0-9]|[01]?[0-9]?[0-9])\.(25[0-5]|2[0-4][0-9]|[01]?[0-9]?[0-9])$
              #regex for a valid ip
^([0-9a-fA-F]{2}[:-]){5}[0-9a-fA-F]{2}$
              #regex for an exactly valid mac address

##########################################################################################################################################################

                                                                    #Day 4#

##########################################################################################################################################################

                                                    #All Starts with Power On Self Test (POST)
                                                        #pushing power button causes this

                                                                  *~~~~~~~~*
                                                                  ###BIOS###
                                                                  *~~~~~~~~*
                                                             ~~~~~~~~~~~~~~~~~~~~
                                                             ##Pre-Boot Process##
                                                             ~~~~~~~~~~~~~~~~~~~~    
                                                          #Master Boot Record (MBR)#
                                                #active partition identified in partition table
                                            #Partition Boot Record on the active partition is loaded
                                                        #Code in the PBR loads bootmgr
                                                                      |
                                                                      v
                                                       #Windows Boot Manager (bootmgr)#
                                                           #manages the boot process
                                                                      |                
                                                                      v
                                                       #Boot Configuration Data Store (BCD)
                                                                      |
                                                                      v
                                                                  #OS Loader
                                                      #(winload.exe) or (winresume.exe)
                                                         #Loads kernel (ntoskrnl.exe)
                                                              ~~~~~~~~~~~~~~~~
                                                              ##Boot Process##
                                                              ~~~~~~~~~~~~~~~~

                                                           #BCD (Legacy Kernel 5)
                                                                      |
                                                                      v
                                                                  #NTOSKRNL
                                                                    ~~~~~~
                                                                    ##OR##
                                                                    ~~~~~~
                                                                #BCD (Kernel 6+)
                                                                      |
                                                                      v
                                                                 #Boot Loader
                                                           #winload.exe/Winresume.exe
                                                                      |                
                                                                      v
                                                                  #NTOSKRNL

                                              *~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*
                                              ###UEFI (Unified Extensible Firmware Interface)###
                                              *~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*
                                                             ~~~~~~~~~~~~~~~~~~~~
                                                             ##Pre-Boot Process##
                                                             ~~~~~~~~~~~~~~~~~~~~
                                                             
                                                          #GUID Partition Table (GPT)
                                                        #used to help format hard drive
                                                                      |
                                                                      v
                                                       #UEFI Boot Manager(bootmgrfw.eft)
                                                           #manages the boot process
                                                                      |                
                                                                      v
                                                       #Boot Configuration Data Store (BCD)
                                                                      |
                                                                      v
                                                                  #OS Loader
                                                      #(winload.efi) or (winresume.efi)
                                                         #Loads kernel (ntoskrnl.exe)
                                                       
                                                                ~~~~~~~~~~~~~~~~
                                                                ##Boot Process##
                                                                ~~~~~~~~~~~~~~~~

                                                                #BCD (Kernel 6+)
                                                                      |
                                                                      v
                                                                 #Boot Loader
                                                           #winload.efi/Winresume.efi
                                                                      |                
                                                                      v
                                                                  #NTOSKRNL

                                                          *~~~~~~~~~~~~~~~~~~~~~~~~~*
                                                          ###Windows Logon Process###
                                                          *~~~~~~~~~~~~~~~~~~~~~~~~~*

                                                        #System (always has PID of 4)
                                                                      |
                                                                      v
                                                                  #SMSS.exe
                              Session 0 Non-Interactive               |                     Session 1 Interactive
                                        ---------------------------------------------------------------
                                        |                                                             |
                                        v                                                             v

                              #SMSS.exe Session 0                                          #SMSS.exe Session 1
                                        |                                                             |
                                        V                                                             v
                        ------------------------------------                           ------------------------------------
                        |                                  |                           |                                  |
                        v                                  v                           v                                  v
       #CSRSS.exe Session 0                      #WININIT.exe session 0       #CSRSS.exe Session 0             #WINLOGON.exe Session 1
                                                            |                                                             |
                                                            v                                                             v
                                          ------------------------------------                           ------------------------------------
                                          |                                  |                           |                                  |
                                          v                                  v                           v                                  v
                                #LSASS.exe session 0              #SVCHOST.exe session 0        #LogonUI.exe session 1           #SVCHOST.exe session 1
                                     #services                           #LSASS                                                         #USERINIT
                                                                                                                                            |
                                                                                                                                            v
                                                                                                                                 #explorer.exe session 1

###BCDEDIT
#the primary tool for editing boot configuration of Windows devices running Windows Vista and newer

bcdedit.exe                     #Display current Boot Configuration Disk (BCD) config

bcdedit /export C:\SAVEBCD      #Backup BCD Configuration
bcdedit /import C:\SAVEBCD      #resets BCD Config to originally backed up version/edit of it

bcdedit /create {ntldr} /d "Windows XP Pro SP2 - Tiger Paw"         #Older then 2003 uses ntldr
                                                                    #newer then 2003 uses bootmgr
                                                                    #/d means Description

bcdedit /displayorder {ntldr} /addfirst                             #adds new partition to the list of partitions

bcdedit /delete {ntldr} /f                                          #deletes all partions/the partition running off of ntldr
                                                                    #/f means force
                                                                    
bcdedit /set {current} safeboot                                     #sets the {current} to load in safeboot mode
                                                                    #current in this case refers to default boot loader
                                                                    #default boot loader is the one that will run if no user selection is made
                                                                                #when multiple boot loaders present
                                                                    
bcdedit.exe /deletevalue {current} safeboot                         #deletes the value that causes {current} to load in safeboot mode
                                                                    #running only what is needed to start device
                                                                    #used when suspected malware or problems with device


###NTOSKRNL
#contains Kernel and executive layers of Microsoft NT Kernel
#responsible for hardware abstraction, process handeling, memory management

##Commands
reg query HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services                        #querys for all services
reg query HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services | findstr Spooler      #querys services on windows device and then finds the one called Spooler
                                                                                      #for windows command line

sc query spooler                       #another way to query services for Spooler
sc query                               #Query for all services



##########################################################################################################################################################

                                                                      #Day 5#

##########################################################################################################################################################
#Garviel box is systemd (run file on /sbin/init to find out)
#Bombadil is sistem5

###Order It Boots in
##Big Mike Got Killed In Russia

#Bios
    #First program to run on startup (Flash or ROM)
    #If stored in flash memory → becomes a target for BIOS Rootkits
    #Performs POST - Power On Self Test
    #Performs system integrity checks
    #Builds a device tree (mice, keyboard, hard drive, video cards, etc..)
    #Reads and executes the first sector on the boot disk (MBR) to load bootloader to memory

#MBR
    #Located at the very beginning of the bootable disk (512 bytes) and contains the primary bootloader, partition table and MBR validity check
    #Contains code for GRUB - Grand Unified Boot Loader
    #(Note: Could also contain LILO - Linux Loader)
    #First 512 bytes of the HD
    #Typically the MBR is located on /dev/hda or /dev/sda (/dev/vda)
    #du - disk usage: summarize disk usage of the set of FILEs
    #df - disk free : displays the amount of disk space available on the file system
    #lsblk - lists information about all available - or specified - block devices


#GRUB
    #Dynamically configurable with the capability to make changes during boot
    #Config File - /boot/grub/menu.lst
    #OS Selection screen where if no choice is made, default kernel specified in the grub configuration file
    #Bootloader (GRUB) passes text based kernel parameters
    #Kernel options are sometimes configurable at the menu with the ‘e’ key

#Kernel
    #Uncompresses itself into RAM
    #Establishes memory management, detects CPU type, page tables
    #Mounts the root ‘/ ’ filesystem
    #kernel is process 0 [kthreadd]
    #Executes /sbin/init or systemd daemon, the very first process started by the kernel with a process ID (PID) of 1
    #‘ls -l /sbin/init’ to determine which Init system you are using

#Init (SysV or SystemD)
    #Configures the environment for the system
      #Looks at the /etc/inittab
      #Available run levels 0 - 6
      #Identifies the default 'init' run level from /etc/inittab and uses that to load all the appropriate programs
      #The entire startup process is handled by scripts

#Runlevels
    #/lib/systemd/system 'ls -l | grep -v wants | grep run’
      #runlevel0.target - > poweroff.target
      #runlevel1.target - > rescue.target
      #runlevel2.target - > multi-user.target
      #runlevel3.target - > multi-user.target
      #runlevel4.target - > multi-user.target
      #runlevel5.target - > graphical.target
      #runlevel6.target - > reboot.target

##For SYSV
    #A runlevel is a software configuration where only a select group of processes exist
      #0 - halt (Do NOT set initdefault to this)
      #1 - Single user mode (switched from multi-user)
      #2 - Multiuser, without networking
      #3 - Full multiuser mode, with networking
      #4 - unused
      #5 - X11 (GUI)
      #6 - reboot (Do NOT set initdefault to this)
    #‘ls -l /etc/rc<1-6>.d’ to see different services run in each runlevel

#The machine’s BIOS or boot firmware loads and runs a boot loader.
#The boot loader(“Grub” located in MBR) finds the kernel image on disk, loads it into memory, and starts it.
#The kernel initializes the devices and its drivers.
#The kernel mounts the root filesystem.
#The kernel starts a program called init with a process ID of 1. This point is the user space start.
#Init sets the rest of the system processes in motion via pre-configured runlevels


##Commands
systemctl get-default           #gets default target from system running Systemd

locate                          #locates a file based on its name
diff <file1> <file2>            #reutns differences between two files

##########################################################################################################################################################

                                                                            #Day 6#

##########################################################################################################################################################

###Windows Process Validity
##Making sure a windows process is valid

##ways to tell
#PID Super High
#If repeating porcess could be
#Pattern in PID
#Misspelled Process Names

#C:\Windows\System32 (normal spot for system process and services to run from)

##Commands
#Task Manager a Gui way to Get-process/tasklist/etc

Get-Process SMSS,CSRSS,LSASS | Sort -Property Id                     #How to discover normal, abnormal, and hidden process and services

Get-Process | Select Name, Id, Description | Sort -Property Id       #shows only process name, id and description then sorts the process list on the ids

Get-Process | Select Name, Id, Path                                  #displays a process list showing only name, id, and the path to where that process is
Get-Ciminstance Win32_service | Select Name, Processid, Pathname     #same as one above but using get-ciminstance

get-service | where-object {$_.Status -eq "Running"} | ft -wr        #gets services, displays only running and format table wrap so no ... at end of lines too big
            #can also do for get-process, etc


get-process chrome | foreach {$a} {$_.modules} | more                #shows chrome and all processes linked to it (modules of it)

tasklist    #cmd wy to get processes
/m          #for modules (how to see dlls)
tasklist /m /fi "IMAGENAME eq chrome.exe"     #seejust module/dll infor for process with name equal to chrome.exe
/fo         #format output (list, table, etc)

/svc        #cmd way to get services

schtasks /query | more              #view scheduled tasks (POSSIBLE FORM OF PERSISTANCE)
get-scheduledtask                   #same as above but powershell

netstat                             #view network connections
netstat -anob                       #a shows all connections and listening ports
                                    #n shows all addressess and port numbers in numerical form
                                    #o displays owning process id associated with each connection
                                    #b displays executable involved in creating each connecion

###User Account Control
#Protocol to protect us fro ourselves
#requesting elevated privileges requires explicit interactive acknologement of the user

#Registry key is located at 
    #"HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System"

#prompts are color-coded
    #Red - Application or publisher blocked by group policy
    #Blue & gold - Administrative application
    #Blue - Trusted and Authenticode signed application
    #Yellow - Unsigned or signed but not trusted application

#UAC execution levels in a files manifest
  #asInvoker - will run with same permissions as the process that started it
  #requireAdministrator - the application will run with administrator permissions
  #highestAvalable - the application will run weith administrator permissions
    #some windows executables can "auto elevate" without a prompt
        #those will not prompt UAC
        
        
##Commands
./strings C:\Windows\System32\*.exe -accepteula | select-string -SimpleMatch "autoelevate"        #sees if binary files has autoelevate as true

./sigcheck -m C:\Windows\System32\slui.exe -accepteula | Select-String -SimpleMatch "level"       #sees if slui.exe is digitally signed




###Windows Sysinteral Tools
net use * http://live.sysinternals.com      #how to download sysinternals
#OR
$wc = new-object System.Net.WebClient
$wc.DownloadFile("https://download.sysinternals.com/files/SysinternalsSuite.zip","$pwd\SysinternalsSuite.zip")
Expand-Archive SysinternalsSuite.zip

##PROCMAN (cracked out process explorer)
.\procmon.exe -accepteula                   #run procmon accepting agreement

##AUTORUNS (like swiss army knife, shows services, scheduled tasks, drivers, runkeys, etc)
.\autoruns.exe

##PROCEXP (like glorified task manager)
.\procexp.exe

##TCPVIEW (see processnames, ids, state, addresses, ports, etc)
.\tcpview.exe

##PSLOGGEDON (Not a GUI shows users logged on locally
.\pslogggedon.exe

##LOGONSESSIONS (not a gui and lists logon session information)
.\logonsessions.exe

##PSLIST  (Not a gui process list) (same as get-process)
.\pslist.exe

##PSINFO (Not a gui gives information about the system)
.\psinfo.exe

##HANDLE (not a gui displays handles) (analyze processes)
.\handle

##########################################################################################################################################################

                                                                        #Day 7#

##########################################################################################################################################################

###Linux Processes

##Kernel Shit
#All kernel processes are fork()ed from [kthreadd]
    #PPID of 2 is from [kthreadd]
#kernel processes run in its own memory space
#has unrestricted access to the processor and main memory
      #powerful but dangerous, can easily crash the whole system if not careful
#area that only the kernel can access is called Kernel Space

#User Shit
#all user processes are fork()ed from /sbin/init or direct ancestor
    #PPID of 1 is from /Sbin/init
#User processes run in a separate memory space
#restricts access to a (usually quite small) subset of memory and safe CPU operations
#only has access to parts of the main memory
      #if mistake made a and crashes the damage is usually limited
      #kernel can clean up mess made by user mode

##Ownership
#Effective User ID (EUID)
    #defines access rights for a process
#Real User ID (RUID)
    #defines the user that can interact with the running process most-signifcantly
            #(who can kill and send sinals to a process)
#Users ID (UID)
    #Users can only modify / interact with files /process that they own or are shared with them
#A user is an entity that can run processes and own files
    #exist mainly to support permissions and boundaries
    #every user-space process has a user

##System Calls
#a system call is an interaction between a process and the kernel

fork()
    #when a process calls fork, the kernel creates a nearly identical copy of the process
exec()
    #when a process calls exec(program) the Kernel starts program replacing the current process

##Orphan and Zombie (DEFUNCT) Processes

#Orphan - Parent process has exited, and is adopted by /sbin/init with PPID of 1
    #all daemons are orphans
    disown -a && exit           #close a shell/terminal and force all children to be adopted

#Zombit (DEFUNCT) - completed process, but still has an entry in the process table
     #stuck waiting on the parent process to give signal to end it
     #cannot be terminated with kill since it already completed executing (unless parent that spawned it is killed)
     #don't use resources but take up space on process table

##Commands

ps                            #List processes in Linux (problem is that ps is a snapshot of an instance)
ps-elf                        #E is every process, L is long format, F is full

top                           #shows live process list 
htop                          #top but with colors

grep UID /etc/login.defs      #looks for UID in etc/login.defs

kill -l                       #lists all options for how to kill with kill command

