#------------------------------------------------------------------------------------------------------------

    write-host "PowerShell Day 1!"
    
#------------------------------------------------------------------------------------------------------------    
    
    write-host "Get-Help!"

Get-Command                         #Gets all available commands in powershell

Get-Verb                            #Gets all available verbs that can be got

Get-Command -verb <verb>            #Displays all verbs that have the verb <verb>
  
Get-Command -Noun <noun>            #Displays all of the commands that have noun <noun>

update-help -Force -ErrorAction silentlycontinue  #updates help documentation
Get-Help <cmdlet>                   #self-explanatory
<#                  -examples       includes examples
                    -detailed       includes details for each parameter and examples
                    -Full           full documentation
                    -online         opens documentation online
                    -ShowWindow     opens documentation in a searchable window
#>
Get-help "<string>"                 #Find command
Get-help about_*                    #Information about CONCEPTS (ie functions, For, While, if)

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
  #                         -autosize
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

    write-host "PowerShell Day 2!"
    
#-------------------------------------------------------------------------------------------------------------
    write-host "Script Block"
    
$myblock = { Get-Service | Format-Table Name,Service }

$myblock                                            #Get-Service | Format-Table Name,Service
& $myblock                                          #runs the block of everytime you call it

#-------------------------------------------------------------------------------------------------------------
    write-host "Sorting"

Get-Childitem | Sort-Object                         #By default sorts alphabetically
<#                          -Property               (length)
                            -Descending             (reverse)
                            -Unique
#>

Get-Childitem | Sort-Object -Property Extension | Format-Table -GroupBy Extension
                                                    #Sorts all files by extension
1, 7, 10, 8, 2, 3 | sort-object                     #sorts the numbers low to high


Get-Childitem | Group-Object {$_.Length -lt 1kb}    #Will create a group for objects that are less than 1kb and those that are not
Get-Childitem | Group-Object -Property Mode         #Will create a group for each type of mode and the members of thosegroups are the files in the dir

Get-Process | select-object -First 10               #Returns only the first 10 processes

Get-Process | Group-Object {$_.Namme.Substring(0,1).ToIpper()} | ForEach-Object{($_.Name + " ") *7; "======="; $_.Group}
<#
this line gets a listing of all processes and groups them by the first letter and makes the group names all capitals
then for each group it changes the name to be that letter repeated 7 times with a space inbetween and then 7 "=" on a new line before displaying the group


#>



#-------------------------------------------------------------------------------------------------------------
    write-host "Filtering"
    
<cmdlet> | where-object{$_.<property> -<comparison operator> <string to match>}

Get-Service | where-object{$_.status -eq 'running'}         #gets only running services
    
get-childitem *.txt | where-object {$_.length -gt 100}      #list txt docs with len greater than 100

get-process | where-object {$_.Company -like 'micro*'} | format-table Name, Description, Company
#                                      -like uses REGEX

get-process | where-object processname -ne "Idle" | sort-object starttime | select-object -last 10 | format-table processname, starttime

get-childitem | measure-object | select-object -expandproperty count    #counts the number of ITEMS in a directory and returns it as an integer
(get-childitem).count

get-childitem | measure-object length | select-object -expandproperty count    #counts the number of files (because only files have a length property) and returns it as an integer


#-------------------------------------------------------------------------------------------------------------
    write-host "Arrays"
    
$array = 1,2,3,4,5
$sum = 0
$array | foreach-object { $sum += $_ }
$sum

#-------------------------------------------------------------------------------------------------------------
    write-host "Comparing Strings"
Compare-Object <string> <string>

"Hello World!" > HelloWorld.txt
$before=(get-content HelloWorld.txt)
"Goodbye world :'(" > HelloWorld.txt
$after=(get-content HelloWorld.txt)

Compare-Object $before $after

#-------------------------------------------------------------------------------------------------------------
    write-host "Creating a custom object"
    
<name>=New-Object object

Add-Member -MemberType NoteProperty -Name <name> -value <Value> -TnputObject <object>
#                        Must use NoteProperty for custom objects
#to change the value of a property

<object>.<property>=<new value>


Add-member -MemberType ScriptMethod -InputObject <object> -name <method> -value {"Going on a roadtrip"}

#shorter way of doing it
$marine = [PSCustomObject]@{
"First" = "Joe"
"Last" = "Mama"
"Rank" = "SSgt"
"MOS" = "1721"
"Position" = "EA"
}

#-------------------------------------------------------------------------------------------------------------
    write-host "PSProviders"

Get-PSProvider 
Get-PSDrive

New-PSDrive -Name HKU -PSProvider Registry -Root HKEY_USERS
#adds the registry hive HKU as a PSdrive so it can now be accessed on Powershell

start-service -name WebClient
New-PSDrive -Name Z -PSProvider FileSystem -Root \\live.sysinternals.com\tools

#-------------------------------------------------------------------------------------------------------------
    write-host "Comparison Operators"
    
-eq -ieq -ceq                       #equals
-ne -ine -cne                       #not equal

    "car" -eq "car"                     #True
    "cars" -eq "car*"                   #False (no wildcards)
    "car","truck","van" -eq "car"       #car

    "car" -neq "caro"                   #True
    "cars" -neq "car*"                  #True (no wildcards)
    "car","truck","van" -eq "car"       #truck
    #                                    van

-gt -igt -cgt                       #greater than
-ge -ige -cge                       #greater than or equal to

    5 -gt 8                             #False
    8 -gt 5                             #True
    15,6,12,4 -gt 8                     #15
    #                                    12

    "A" -gt "B"                         #False
    "C" -gt "B"                         #True       (ASCII order)

-lt -ilt -clt                       #less than
-le -ile -cle                       #less than or equal to

    5 -lt 8                             #True
    8 -lt 5                             #False
    15,6,12,4 -lt 8                     #6
    #                                    4

-like -ilike -clike                 #string matches wildcard pattern
-notlike -inotlike -cnotlike        #string doesn't match wildcard pattern

    "Goodbye" -like "Go*"               #True
                    <# *            any # of any characters
                       ?            any single character
                       [1, 2, 3]    any of the characters in like list
                    
                    #>

    "Powershell", "Server" -notlike "*shell"    #server


-match -imatch -cmatch              #matches REGEX pattern
-notmatch -inotmatch -cnotmatch     #does not contain regex pattern

    $text = 'Here is the model number: MO5364'
    $pattern = 'MO(\s[3])'
    $text -match $patter                #True because the string in $text contain MO followed by 3 digits

-replace -ireplace -creplace        #replaces strings matching REGEX pattern

-contains -icontains -ccontains     #used for a collection of items
-notcontains -inotcontains -cnotcontains    #Collection does not contain a value

    $fruit = 'apple','orange','pear','tomato'
    $fruit -contains "pear"                     #True


-in                                 #returns true when value is contained in collection
-notin                              #value is not in a collection
    
    $nums = 1..34
    8 -in $nums                     #True


-is                                 #returns true if both objects are the same type
-isnot                              #returns false if both objects are the same type

    write-host "Combining Operators"

$num =5
(($num -gt 1)) -and (($num -lt 4))  #False

$num =5
(($num -gt 1)) -and (($num -lt 6))  #True

$num =5
(($num -gt 1)) -or (($num -lt 4))  #True

$num =5
(($num -gt 5)) -and (($num -lt 6))  #False

#-------------------------------------------------------------------------------------------------------------




#-------------------------------------------------------------------------------------------------------------



#-------------------------------------------------------------------------------------------------------------



#-------------------------------------------------------------------------------------------------------------



#-------------------------------------------------------------------------------------------------------------



#-------------------------------------------------------------------------------------------------------------


##############################################################################################################

<#
Order of PoSh Cmdlet
1. Alias
2.Functions
3.cmdlets
4.Path Enviroment Variables
#>

