Get-Process SMSS,CSRSS,LSASS | Sort -Property Id    #Check if the 3 processes are valid
Get-Process | Select Name,Id,Description | sort -Property Id  #Check the descriptions of all running processes
                      #can be located with Path
                      #PriorityClass
                      #use get-member
tasklist
         #/v  more info  
         #/m  Modules including
         #/fi "IMAGENAME eq chrome.exe"
              #EQU - Equal to.
              #NEQ - Not equal to.
              #LSS - Less than.
              #LEQ - Less than or equal to.
              #GTR - Greater than.
              #GEQ - Greater than or equal to.
Get-Ciminstance Win32_service | Select Name, Processid, Pathname
Get-service       #will give you the state of the services

Scheduled Task
task scheduler (GUI)

schtasks /query | more
get-scheduledtask | select *
get-scheduledtask | select Taskname,State | where-object -Property State -match 'Running|Ready'

Network Connections
netstat -anob     #net connections and process/pid
