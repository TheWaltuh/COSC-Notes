

############################################################################################################################################################

                                                                        #Review#

#############################################################################################################################################################
                                                               LOOK FOR ANTHING ABNORMAL
###Linux
##First Steps you wanna do
#Figure out if systemd or systemv
#check for running processes
      ps -elf
        ps -elf | grep <pid>
            #-> show only wanted pid
      htop  
         #-> (gives live look)
      systemctl status <pid of process looking at>
             #-> (gives more information about processes after ps-elf
#Look at network connections
      sudo netstat -anop
      sudo netstat -ltp
          #both work second only shows active connections versus anop shows all of them
          #use sudo to make sure it shows all processes cause just running them may not have perms to see all
#Check scheduled tasks
      #Cron jobs
      #more than 1 directoy
      #/etc/cron.*
      #/var/spool/cron
      #/etc/cron.d
      #and the file /etc/crontab

#Profiles
      /etc/profiles
            #(controls system wide default variables)
            #cat this file to check persistance
###Windows
net user <username>
      #get all information on a user
      
#Check Runkeys
##Two Types Run and Run Once
HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Run
HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\RunOnce
HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Run
HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\RunOnce
        (have for all 5 HKLM,HKCU,HKU,HKCC,HKCR)
reg.exe query 
    #run this with path to key to see whats up
    #can also use Regedit for GUI

#Powershell Profiles
Test-Path -Path $profile.AllUserscurrentHost
          #TEST TO SEE IF IT EVEN EXISTS
($profile).AllUsersAllHosts
          #get filepath for the profile

#Scheduled tasks
    #sysinternals (get command to install)
              net use * http://live.sysinternals.com
    Gui is open "Scheduled Task"
          #that will open task sceduler to check for if anytthing fucked
#Running processes
    get-process
    task manager also work

#Check Network Connections
    netstat -anob
    get-nettcpconnection



#Artifacts
#WIndows Background Activity Monitor (BAM)
#a windows service that controls activity of background applications

#for windows 1709 and 1803
get-itemproperty 'HKLM:\SYSTEM\CurrentControlSet\Services\bam\UserSettings\*'

#For windows 1809 and newer
get-itemproperty 'HKLM:\SYSTEM\CurrentControlSet\Services\bam\state\UserSettings\*'

##Recycle Bin
#important location for forensic analysis
#cannot cd into (is hidden in c drive)

gci 'C:\$RECYCLE.BIN' -Recurse -Verbose -Force | select *

gci 'C:\$RECYCLE.BIN' -Recurse -Force
#Stores details for each user account
#history will record access to the file on the website that was accessed via the link

##view history
.\strings.exe 'C:\Users\<username>\AppData\Local\Google\Chrome\User Data\Default\History'
#or
strings 'C:\Users\<username>\AppData\Local\Google\Chrome\User Data\Default\History'

##view top sites
strings 'C:\Users\<username>\AppData\Local\Google\Chrome\User Data\Default\Top Sites' -accepteula

##Recent Files
#Registery Key that will track the last files and folders opened, Recent menus in start menu
#Overall key will track overall order of last 150 files opened

#list files in recent docs
gci 'REGISTRY::\HKEY_USERS\*\Software\Microsoft\Windows\CurrentVersion\Explorer\RecentDocs'

#convert file hex into unicode
[System.Text.Encoding]::Unicode.GetString((gp "REGISTRY::HKEY_USERS\*\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\RecentDocs\.txt")."0")

#Jump Lists
#Its the taskbar

gci -Recurse C:\Users\*\AppData\Roaming\Microsoft\Windows\Recent -ErrorAction Continue | select FullName, LastAccessTime


get-childitem C:\Users\student\Appdata\roaming\microsoft\windows\recent\AutomaticDestinations | %{strings -accepteula $_} >> C:\recentdocs.txt




