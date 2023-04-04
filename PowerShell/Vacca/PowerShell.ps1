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

    write-host "variables"
    
#microsoft loves money $$$

Get-Variables                                       #Lists all variables
Get-ChildItem variable:                             #^

$x = 10
$X                                                  #10     Case insensitive to call

remove-variable x                                   #self explanatory
del variable:x                                      #same ^

Get-Variable <var no dollar signs>
Get-Childitem variable:<var no dollar sign>         #these would print what the var is equal to

$x, $y, $z = "one", "two", "three"                  #x="one" y="two" z="three"
$x = $y = $z = "one"                                #x y and z = "one"

Test-Path <path>                                    #verifys path exists

Test-Path variable:<var>                            #returns True or False if variable exists or not

    write-host "Variable Expansion"

$name = "Joe"
write-host "Hello $name"                            #Hello Joe 
write-host 'Hello $name'                            #Hello $name

$hour = (Get-Date).hour
$remain = 24 - $hour
$remain                                             #hours remaining in the day

$day = (get-date).dayofyear
$daysremain = 365 - $day
$daysremain                                         #Returns days remaining in the year

(Get-Date).Hour.GetType()                           #GetType() method can tell what type a variable is

    write-host "Automatic Variables"
    
$args                                               #Array of undeclared parameters
$false                                              #False
$true                                               #True
$input                                              #Enumerator of all input passed to a function
$matches                                            #Hashtable of the current match for a 'match'
$null                                               #Black Hole
$profile                                            #String that contains path to the default powershell profile
    
$PWD                                                #Current working Directory

    write-host "Enviromental Variables"

Get-Childitem env:                                  #lists all enviromental variables

$env:<name>                                         #how to call and enviromental variable

cd $env:HOMEPATH                                    #changes to the directory that is the users home directory


    write-host "Variable Types"
    
[string]                                            #sefl explanatory
[char]                                              #16-bit single unicode character
[byte]                                              #8-bit unsigned character
[int]                                               #32-bit signed integer
[long]                                              #64-bit signed integer
[single]                                            #32-bit floating poiint number
[double]                                            #64-bit floating point number
[float]                                             #32-bit floating point number
[datetime]                                          #Date and Time
[array]                                             #self explanatory

(86.2).GetType().name                               #Double
([float](86.2)).GetType().name                      #Single

$var = Read-Host; [int]$var                         #User input is always read as a string and must be TYPECASTED

write-host "Numbers ending in .5 always round to the nearest even integer"

[int]5.5                                            #6
[int]6.5                                            #6
[int]4.5                                            #4

[int]5.3                                            #5
[int]5.7                                            #6







#-------------------------------------------------------------------------------------------------------------





##############################################################################################################

<#
Order of PoSh Cmdlet
1. Alias
2.Functions
3.cmdlets
4.Path Enviroment Variables
#>

