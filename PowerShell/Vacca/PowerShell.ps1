##
##
##
    write-host "PowerShell Day 1!"
    
#------------------------------------------------------------------------------------------------------------    
    
    write-host "Get-Help!"

Get-Command #Gets all available commands in powershell

Get-Verb    #Gets all available verbs that can be got

Get-Command -verb <verb>     #Displays all verbs that have the verb <verb>
  
Get-Command -Noun <noun>  #Displays all of the commands that have noun <noun>

update-help -Force -ErrorAction silentlycontinue  #updates help documentation
Get-Help <cmdlet>                   #self-explanatory
<#                  -examples       includes examples
                    -detailed       includes details for each parameter and examples
                    -Full           full documentation
                    -online         opens documentation online
                    -ShowWindow     opens documentation in a searchable window
#>
Get-help "<string>"                   #Find command
Get-help about_*                      #Information about CONCEPTS (ie functions, For, While, if)

#-------------------------------------------------------------------------------------------------------------
    
    write-host "Parameters"

Get-Childitem
# Named parameters (must specify what)
              -Path C:\windows
# Switch Parameters (either on or off)
              -Recurse
# Positional Parameters (already expects the -path parameter)
              C:\windows

#-------------------------------------------------------------------------------------------------------------

  write-host "Alias"
  
 Get-Alias                          #Shows all alias for all cmdlets (get-childitem alias:)
 <#
            -name <alias>           #Gives the cmdlet that is linked to that alias
            -definition <command>   #Gives alias that are linked to the command
 #>
$alias:<command>                    #Displays cmdlet linked to alias


Set-Alias <name> <definition>       #creates an alias called <name> that executes <definition>

get-childitem alias:                #lists the directory containing all of the alias
remove-item alias:<name>            #removes an alias from the alias drive

#-------------------------------------------------------------------------------------------------------------

  write-host "Properties and Methods"

get-process notepad                 #displays a table of process properties
(get-process notepad).Id            #would only display the ID for the process notepad
#Properties can be comma seperated (ie name,id)

#Property is something about an object
#Method is something an object can do

Get-Member                          #gets members of an object (properties and methods)
<cmd string> | get-member           #gets the members of the output of the cmd string
# Not the same as:
get-member -InputObject <object>    #Gets the members of the object

<cmd string> | get-member -MemberType <member type>         #displays specified member type
  
#-------------------------------------------------------------------------------------------------------------

  write-host "Pipeline"
  
get-childitem | out-default

<cmd string> | Format-custom
  #outputs a custom format with default properties
<cmd string> | Fortmat-List
  #outputs a list with default properties
<cmd string> | Format-Table
  #outputs a table with default properties
<cmd string> | Format-Wide
  #outputs a wide table with default properties

<cmd string> | format-<style> -Property <property>,<property> #formatted output with chosen properties  
  
#------------------------------------------------------------------------------------------------------------

  write-host "functions"
  
function fruit-host {
write-host "Apple"
write-host "Orange"
write-host "Banana"
write-host "Pear"
}
  
function fruit-output {
write-output "Apple"
write-output "Orange"
write-output "Banana"
write-output "Pear"
}
  
fruit-host | sort       #doesn't sort because it is already written to host
fruit-output | sort     #sorts because is is written to the output of that cmdlet
  
#------------------------------------------------------------------------------------------------------------

##############################################################################################################

<#
Order of PoSh Cmdlet
1. Alias
2.Functions
3.cmdlets
4.Path Enviroment Variables
#>


<#
cmdlets we use in class:

Get-Process                   #lists all processes
Get-Childitem                 #directory listing






#>
