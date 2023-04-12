#-------------------------------------------------------------------------------------------------------------------
  write-host "Day 1!"
#-------------------------------------------------------------------------------------------------------------------
get-host                  #enumerates information about the host machine

  "Cim"
get-cimclass              #Newer suppported system information giver for microsoft (replacced get-wmiobject)
get-CimInstance           #get an instance of CIM
get-ciminstance Win32_Process -Filter 'name like "p%"'

get-executionpolicy   

$profile | get-member -MemberType NoteProperty | fl      #shows the profiles and their propertys in a list
#if a profile location is not in its default location then it is an anomoly

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

#-------------------------------------------------------------------------------------------------------------------
  write-host "Day 2"
#-------------------------------------------------------------------------------------------------------------------

#Tools to manipulate the registry:
regedit.exe: GUI, C:\Windows\regedit.exe
reg.exe: CLI,C:\Windows\System32\reg.exe
  reg add, reg query, reg delete

HKEY_LOCAL_MACHINE
#HKLM pertains to the entire computer
  Hardware
  SAM
  Security
  System
HKEY_USERS
#HKU is for all user enviroment settings
  Symbolic link to 
HKEY_CURRENT_CONFIG
#HKCC is a symbolic  link to HKLM\SYSTEM\CURRENTCONTROLSET\'Hardware Profiles'\Current
HKEY_CLASSES_ROOT
#HKCR

Get-LocalUser | select name, sid   #will get the sid for all user accounts

#persistence is etablished in:
HKLM:\Software\Microsoft\Windows\CurrentVersion\Run
To view: Get-Childitem, Get-Item

New-PSDrive -Name FileServer -PSProvider FileSystem -Root "\\file-server\warrior share"
#connects Powershell to a network share drive

  write-host "Alternate Data Streams"
  
#essentially logical pointers to another data set than what is actually located within a file
[filename.extension]:[alternate_stream_name]:$DATA

to view ads:
  get-item <item> -stream *                 #lists all data streams
  get-content <item> -stream <streamname>   #Shows the content of the ADS for a file







#-------------------------------------------------------------------------------------------------------------------

#-------------------------------------------------------------------------------------------------------------------

#-------------------------------------------------------------------------------------------------------------------

#-------------------------------------------------------------------------------------------------------------------
Get-ChildItem -Filter *.abc -Recurse | Select-String -Pattern '^(?=.*\bword1\b)(?=.*\bword2\b)(?=.*\bword3\b).*$'
Get-CimInstance -ClassName win32_service | Where-Object -FilterScript {$_.name -eq "legoland"}
Compare-Object -ReferenceObject $file -DifferenceObject $file2 -IncludeEqual

  
  
  
  
  
  
  
