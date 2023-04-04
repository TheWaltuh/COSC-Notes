xfreerdp /u:student /v:10.50.63.163 +glyph-cache +clipboard +dynamic-resolution #runs gui to be able to do powershell in student workstation

###############################################################################################################################################
#get-help and other basic commands
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
get-command #gets all commands avalable to you in powershell

get-verb #displays all verbs for powershell commands

get-command -verb <verb> #displays all commands that have the verb that comes after -verb

get-command -noun <string> #displays all powershell commands that have the noun <string> 

Get-process #displays all processes currently running on the machine (does same as tasklist and can use tasklist)

get-help <cmdlet> #does as it says

update-help -force -erroraction SilentlyContinue #updates the documentation for powershell

get-help <command> -Examples #shows examples of command in use

get-help <command> -Detailed #shows syntax, description, parameter ino, and examples of command

get-help <command> -Full #full documentation or command

get-help <string> #finds commands

Get-Help about_* #shows documentation for powershell concepts (aliases, functions, etc)

get-help <command> -Online #opens documentation in web browser

Get-Help <command> -ShowWindow #open documentation in searchable window


#################################################################################################################
##parameters
~~~~~~~~~~~~
Get-ChildItem

#named parameters
                -path C:\Windows   #comes in Key/value pair
#switch parameters
                -recurse   #if parameter s there switch is on
#positional paramters
                C:\Windows #get-childitem expects -path first
                           #cmdlets expect default parameter order, and parameter values can be given without naming parameters for those

#################################################################################################################
#aliases
~~~~~~~~
get-alias #gets list of all aliases

get-aslias -name <alias> #gives command that is linked to alias
Get-Alias -Definition <command> #gives all alsiases that are linked to command

Get-ChildItem alias: #lists content of aslias PSDrive
$alias:<alias> #displays command links to alias


Set-Alias <name> <definition> #creates aliases (all ones user created auto del at closing of session)
Remove-Item alias:<name> #deletes alias

##########################################################################################################################
###more less basic commands
~~~~~~~~~~~~~~~~~~~~~~~~~~~

Get-Member #gets members of an object

<command string> | Get-Member #gets the members of the output of the command string
<command string> | Get-Member -MemberType <member type> #displays just the specificified member type for the object
                                                        #that is the output of the command string


Get-Member -InputObject <command> #gets the members of the object

get-service                 #displays list of services installed on local computer
Show-NetFirewallRule        #displays a list of windows firewall rules

Get-process                 #displays all processes currently running on the machine
(get-process).processname   #displays only processnames from get-process (can use for diferent fields then just name obviously)
Get-Process notepad.exe     #displays all process info for notepad.exe

get-childitem               #directory listing

("string").GetType().Name   #gets the name o the data type hta is in the first set of ()

####################################################################################################################################################
###pipeline
~~~~~~~~~~~

###Format Pipeline Output
<command string> | Format-Table  #output a table with default properties (used more ofthen)
<command string> | Format-List   #outputs a list with default properties (used more often)
<command string> | Format-Wide   #outputs a wide table with default properties
<command string> | Format-Custom #outputs a custom format with deault properties
<command string> | Format-Table -Property <property>,<property> #formatted output with chosen properties
            Get-Process | Format-table -Property Name,id # displays output of get-process as a table only showing the name and id properties

#property is something about an object
#method is something the object can do

###############################################################################################################################################
###Functions
~~~~~~~~~~~~

function fruit-host {
    Write-Host "Apple"
    Write-Host "Orange"
    Write-Host "Banana"
    Write-Host "Pear"
}

function fruit-output {
    Write-Output "Apple"
    Write-Output "Orange"
    Write-Output "Banana"
    Write-Output "Pear"
}

fruit-host | sort   #doesnt sort because written to the console so cannot pipe write host
fruit-output | sort #only sorted because written to output of the cmdlet

###########################################################################################################################
###Variables
~~~~~~~~~~~~
              #python             BASH               PoSH
#inst.         var                var                $var
#call          var               $var                $var

Get-Variable                 #lists all variables 
Get-ChildItem variable:      #also lists all variables by listing contents of variable PSDrive

$x = 10 #spaces dont matter in PoSH unlike bash, and again not case sensitive

Get-Variable <variable, no dollar sign> #gives name and value of variable. DO NOT use $ in front of the variable name.
Get-ChildItem variable:<variable, no dollar sign> #same as above

$var1, $var2, $var3 = <value1>, <value2>, <value3> #sets variabels to their respective values
$var1 = $var2 = $var3 = <value #sets all vars to same value

Test-Path <path> #verifies that variable exists


Test-Path variable:x #verifies that variable exists

Remove-Variable <variable> #removers variables
del variable:<variable>    #alias of remove-variable

###variable expansion
$name = "Jon"
Write-Host "Hello $name"      #writes Hello Jon (expands variable when writing the string)
Write-Host 'Hello $name'      #writes Hello $name

(Get-Date).Hour.GetType()  #shows type of data returned from (get-date).Hour

$hour = (Get-Date).Hour
$remain = 24- $hour
$remain

$day = (Get-Date).DayOfYear
$daysleft = 365- $day
$daysleft
  

##Automatic Variables
    
$args      #Array of undelared paraeters
$false     #false
$true      #true
$input     #enumerator of all input passed to a function
$Matches   #Hashtable of the current match for a "match" comparison
$null      #blackhole (like /dev/null)
$profile   #string that contains the path to the default powershell profile
$PWD       #current working directory


while($true) #needs $true not just true for PoSH

##Environmental Variables

Get-ChildItem env:    #lists all environmental variables

$env:<name of environmental variable> #how to call

cd $env:HOMEPATH #hw to cd to homepath environmental variable (cd itself being a variable for set-location)

##Variable Types

[string]          #Fixed-Length string of unicode characters
[char]            #16-bit unicode character
[byte]            #8-bit unsigned character
[int]             #32-bit signed integer
[long]            #64-bit signed integer
[single]          #32-bit floating point number
[double]          #64-bit floating point number
[float]           #32-bit floating point number
[datetime]        #Date and Time
[array]           #self-explanatory

([float]86.225).GetType().Name       #works because converting 86.225 to float before running GetType()
[float](86.225).GetType().Name       #don't work because is tryng to convert output of the GetType to a float

$var= Read-Host; [int]$var           #read-host data is automatically a string so must type cast if wanting to do math or other such things with inputed data


#PoSh rounds to the nearest even number WHEN ENDING IN .5
[int]5.5
[int]6.5
#both of those will return 6
[int]5.7
#that will round to 6


#################################################################################################################
<#
Order of Powershell Cmd Search Order Execution
1.Aliases
2.Functions
3.Cmdlets
4.Path Environment Variable

#>

#########################################################################################
