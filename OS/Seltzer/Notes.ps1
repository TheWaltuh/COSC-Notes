Stack Number - 16
admin server - 10.50.22.160

############################################################################################################################################################

                                                                            Day 1

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





















