Stack Number - 16
admin server - 10.50.22.160

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
 














