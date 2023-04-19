######################################################################################################
"Linux Process Validity"
######################################################################################################
################################
Process
################################
ps -elf     #list all process
[]          #If a process name has brackets: its a kernel process
--forest    #tree format
--PPID <\#>      #specify PPID


PPID:
1:  user process (/sbin/init)
2:  Kernel Process ([kthreadd])

top     #live version of all process but non-configurable
htop    #configurable

grep UID /etc/login.defs    #View the configured EUIDs and RUIDs
ps -eo ruid,euid,pid,cmd
#RUID 1000-60000
#EUID 100-999

#####################################
System Calls
#####################################

#fork - creates a new process by duplicating the calling process. The new process is referred to as the child process. The calling process is referred to as the parent process.
#  The fork “processes” can be explained as the recreation of a process from system space and duplicated into user space in an attempt restrict user access to system processes/space.
#exec - When a process calls exec, the kernel starts program, replacing the current process.

Linux - Signals
kill -l         #lists kill signals


#Services#################################
service --status-all (SysV)
systemctl list-unit -all (SystemD)

#Job#######################################
ping 8.8.8.8 &
fg
ctrl+z
jobs
kill -9 %1

############################################################################
CRON
############################################################################
The cron daemon checks:
ls -l /var/spool/cron #user jobs
ls -l /etc/cron.d
ls -l /etc/crontab #system jobs

crontab -u [user] file  #This command will load the crontab data from the specified file
crontab -l -u [user]    #This command will display/list user’s crontab contents
crontab -r -u [user]    #This Command will remove user’s crontab contents
crontab -e -u [user]    #This command will edit user’s crontab contents

  ┌───────────── minute (0 - 59)
  │ ┌───────────── hour (0 - 23)
  │ │ ┌───────────── day of the month (1 - 31)
  │ │ │ ┌───────────── month (1 - 12)
  │ │ │ │ ┌───────────── day of the week (0 - 6) (Sunday to Saturday;
  │ │ │ │ │                           7 is also Sunday on some systems)
  │ │ │ │ │
  │ │ │ │ │
  * * * * * <Time/Day to execute    "Command to Execute"

(Mnemonic: Minnie Has Daily Money Worries)
* The syntax of each line expects a cron expression made of five fields, followed
by a shell command to execute.

ProcDir####################

ps -elf | grep sshd   #get pid of ssh session
ls -l /proc/<pid>
#exe is a link to the actual binary for the executable

lsof -c sshd      #lists open files for specified process






