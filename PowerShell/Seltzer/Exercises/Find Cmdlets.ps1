Practical Exercise: Find Cmdlets

1. Ensure that you have the latest copy of help by updating your help system.
update-help -force -erroraction SilentlyContinue

2. Which cmdlets deal with the viewing/manipulating of processes?
Get-process			#show prunning processes
start-process			#start a process
stop-process			#end a process
wait-process			#stop running a process without ending it

3. Display a list of services installed on your local computer.
get-service

4. What cmdlets are used to write or output objects or text to the screen?
write-output
write-host

5. What cmdlets can be used to create, modify, list, and delete variables?
get-variable		#list all variables
$<var>
new-variable
set-variable
remove-variable

6. What cmdlet can be used, other than Get-Help, to find and list other cmdlets?
get-process

7. Find the cmdlet that is used to prompt the user for input.
read-host
