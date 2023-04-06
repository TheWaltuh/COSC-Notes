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
foreach($item in $arr) {
start-process $item
get-process $item | Sort-object ID | format-table -property ID, ProcessName,Starttime,TotalProcessorTime,VirtualMemorySize,Workingset64
stop-process -name $item
}
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

##########################################################################################################################################################

                                                                  #Start of Day 2#
                                                                  
##########################################################################################################################################################

###Script Block
$myblock = { Get-service | format-table name, status }  #gets list of services and outputs to a table showing name and status
& $myblock                                              #how you run a scrip block
                                                        #everytime called it runs again, so goes through the commands inside again
 
$<script block name> = { <commands to be in block> }    #basic syntax

###Sorting

get-childitem | Sort-object                             #sorts present working directory alphabetically 
                                    -descendin          #high to low (this case/order would be largest file to smallest)
                            length                      #size of file



get-childitem |                                                                           #lists present working directory
                sort-object -property Extension |                                         #sorts output of cmdlet piped into it by the extension that the file is (.dll,.txt,etc)
                                                  format-table -groupby Extention         #presents output of cmdlet piped ino it as a table groupng by extension

get-service | sort-object status                        #sorts the output of get service by the status of the service


get-childitem |                                         #known what this does
                group-object {$_.Length -lt 1kb}        #outputs only those that are less then 1 kb
                                                        #$_ variable that refers to value that is going through the pipeline ($psitem is same thing)
                                                        #sort-object will display the files that are lt 1kb not just how many

1,7,10,8,2,3 | Sort-Object                              #returns numbers in ascending order


get-process | group-object {$_.name.substring(0,1).ToUpper()} |                                                               #groups output piped in by name of the process and cause o substring(0,1) takes first letter
                                                                                                                              #to upper just capitalizes it
                                                                                                                              #substring the 0 says skip 0 letters and 1 says grab 1 letter
                                                                foreach-object{($_.name + " ") *7; "=========="; $_.Group}    #then prints the letter from output 7 times and returns "==========" below, bewfore finally under that grouping process by the letter
                                                                                                                              #final processes are returned under the letter that they start with

###Expanding properties

get-process | select-object Name, ID                                             #returns only the name and id from the get-process command

<command string> | sort-object processname | select-object -first <n>            #sorts by the processname and then returns first N objects from output piped into selet-object command

Get-Service | Select-Object -ExpandProperty displayname                          #fully displays command output of the option given (can only show one option at a time this way)

get-service | format-table -autosize                                             #displays command output in full

###filtering of results
where-object                      #filtering command
select-object                     #to grab certian either objects or properties


Get-Service |Where-Object{$_.Status -eq 'running'}                              #displays only the output from irst command that has a status of running

get-childitem *.txt | Where-object{$_.Length -gt 100}                           #first part gets anything in currend working directory that ends in .txt
                                                                                #second filters out returning only those with a length greather than 100
get-process | Where-object {$_.Company -like "micro*"} | format-table name, description, Company
                                                                                #where-object filters returning only objects from piped output that were made by a company that starts with micro
                                                                                #displays sorted output in a table with the name, description and company displayed
                                                                                #company is a script property, wheich just means that company is running a script to get a property in this case the creating company
get-process | where-object {$_.name -notlike 'powershell*' | sort-object id -decsending
                                                                                #gets all processes, sorts removing all that have powershell at beginning or as name
                                                                                #then sorts those processes on id and returns then greatest to least

get-process | where-object processname -ne "idle" | sort-object starttime | select-object -last 10 | format-table processname, starttime

###more commands

1,2,3,1,2,3,1,2,3,1,2,3,1,2,3 | sort-object | get-unique                        #sorts the list and then returns each character but only once so in this case returns 123
                                                                                #returns only unique characters
                                                                                #items must be sorted to use get-unique

get-childitem | measure-object                                                  #returns with count of items in current working directory, and has spots to get average, sum, maximum, minimum and property

get-childitem | measure-object Length                                           #returns a count of how many files are in the current working directory
                                                                                #does now show directories, and depending if no iles where you are it will return an error
                                                                                
get-childitem | measure-object -line                                            #returns number of directories and files in current working directory

(get-childitem).count                                                           #returns a count of how many items returned by get-childitem (in this case all files and directories)

get-PSProvide                                                                   #gets information about specified powershell provider

get-PSDrive                                                                     #gets information on what ps drives are avalable to you
new-PSDrive -Name HKU -PSProvider Registry -Root HKEY_USERS                     #creates a new PSDrive with provider being Registry and the root being HKEY_USERS
get-childitem <PSDRIVE>:                                                        #how to read/view the drives in PSDrive

new-PSDrive -name Z -PSProvider FileSystem -root \\live.sysinternals.com\tools  #another way to create a new PSDrive
start-service -Name WebClient                                                   #enables webclient to allow browsing of the file system

set-content -path .\example.txt -value "a string"                               #write content to a file
get-content .\example.txt

add-content-path .\example.txt -value "an additional string"                    #append content to a file
get-content .\example.txt

<Command string> | Format-List *                                                #view everything that is there when command string is run (includes hidden shit)

###Arrays
#basically is a list but

$array = 1, 2, 3, 4, 5                                                           #creates an array called $array
$sum = 0                                                                         #creates a empty variable named sum
$array | foreach-object { $sum += $_ }                                           #goes through each item of the array and adds it to sum
$sum                                                                             #returns sum (so would be sum of all items in the array


~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
'what is the answer to life, the universe, and everything?' > text.txt
$before = get-childitem

'42' > test.txt
$after = get-childitem

compare-object $before $after -property Length, Name      #compairs the $before to $after
                                                          #in this case is the get-childitem with test.txt befre the change to get-childitem with test.txt after the change
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

###Objects

$MyTruck = New-Object Object                              #creates a new object named MyTruck

###Properties
add-member -membertype NoteProperty -name Color -value Red -inputObject $MyTruck
                                                          #adds m emeber to $MyTruck object
                                                          #name of member is Color, and the value of it is Red
                                                          #the member type is NoteProperty (use NoteProperty for custom made objects cause they uses arbirtary data)
                                                              #not .net data being uses so need NoteProperty
add-member -membertype NoteProperty -name Make -value Ford -inputObject $MyTruck
                                                          #Same deal as above just new memeber Name being make and value being Ford
        #to change a property set the >Object>.<property want to change> = <what you want to change it to>
        $MyTruck.model="F-250"

$MyTruck | add-member NoteProperty Cab SuperCrew          #alternate way of making members for an object by piping it in

<object>.psobject.properties.remove('<property ro remove>')   #how to remove properties from a object

###Methods

add-member -membertype ScriptMethod -inputobject $MyTruck -name Drive -value { "Going on a road trip" }
                                                          #adds a method named Drive with a calue of "Going on a road trip" to $MyTruck

add-member -inputobject $MyTruck ScriptMethod Accelerate { "Skinny Pedal on the Right" }
                                                          #alternate way to add method

###Creating custom objects

$Marine = new-object -typename PSCustomObject             #creates custom object named marine
                                                          #adding properties and methods works the exact same as above

#Below is another way to make a custom object
#@{} make it so anthing written inside the {} is written to a hash table of the pscustom object
$soldier = [PSCustomObject]@{
     "Firstname"      = "Joe"
     "LastName"       = "ShitBird"
     "MilitaryRank"   = "SSGT"
     "MOS"            = "17c"
     "Position"       = "Host Analyst"
}
$soldier

###Compairison operatiors
-eq, -ieq, -ceq #Equals
5,6,7,3 -eq 3 #when compairing multiple to one will rreturn the mathcing if no matching will return nothing
              #can be done on strings
              #no wildcard with equal has to be exact
              
-ne, -ine, -cne #Not equals
              #same deal as eq but opposite so when compairing multiple wll only return those that dont match
              #can be done on strings
              #no wildcard useable to try and cheat 
              
-gt, -igt, -cgt #greater than
"Cows" -gt "Cats" #returns true b/c goes pice by piece seeing which lettter is gt , stops when inds non equal value letters

-lt, -ilt, -clt #Less Than
                  #same deal as greater than

-ge, -ige, -cge #greater than or equal to

-le, -ile, -cle #Less Than or equal

-like, -ilike, -clike #string matches wildcard pattern
"cat" -like "C*"  #returns true b/c is any word that starts with c and cat starts with c
                  #like eq but can use regex and wildcards
                  #lists return only those that match

-notlike, -inotlike, -cnotlike #string does not match wildcard pattern
                  #like not equal but can use regex and wildcards
                  #lists return only those that dont match

-match, -imatch, -cmatch #string matches regex pattern
$text = 'Here is the model number; Mo5364'
$patterb = 'Mo(\d{3})'
$text -match $pattern
                  #script shows that if text has pattern(Mo followed by 3 digits (nums)) in it
                  #since it has Mo5364 (3 or more numbers following Mo it matches

-notmatch, -inotmatch, -cnotmatch #string does not match regex pattern

-replace, -ireplace, -creplace #replaces strings with a matching regex pattern

-contains, -icontains, -ccontains #contains (used for a collection of items)
$fruit = "Apples", "Oranges", "Peaches", "Pears", "Plumbs"
$fruit -contains "Plumb"
                 #script will return true because Plub is in the array of fruits

-notcontains, -inotcontains, -cnotcontains # collection does not contain a value

-in #returns true when a value is contained within a collection

-notin #value is not in a collection

-is #returns true if both objects are the same type

-isnot #returns true if the objects are not the same type

###Regex
the * #wildcard matches zero or more characters
the ? #ill match a single character
[a-z] #will match a range of characters from a-z
\d    #any digit 0-9


###If Statements
#elseif not elif

$x=5
i ($x -gt 10){"$x is greater than 10"}

if ($x -eq 5){
    write-host "Conditon is true - x is equal to 5" -ForegroundColor Red
}



###Switches
#used to test more then one value
#unlike if statements will go through all options before quitting

$choice = read-host("Please choose a number between 1 and 3")
switch($choice){
  1{"Powershell is the bestest"}
  2{"Bash is more better"}
  3{"Um actually, Python is the best"}
}

Switch(10)
{
    (1 + 9) {
        "Congrats you did adds right"
        }
    (1 + 10) {
        "Congrats you did adds wrong"
        }
    (10 - 1) {
        "Congrats you did subs right"
        }
    (10 - 2) {
        "Congrats you did subs wrong"
        }
}

$val = "Meg"
switch($val){
    Peter {"Thats the father!"}
    Lois  {"Thats the mother"}
    Chris {"Thats the retard brother"}
    Brian {"Thats the dog"}
    default {"Nobody cares about you $val"}\
    
}
          #for this switch since it doesnt match any of them it will return the default switch
          

###for loops

for($i=0; $i -le 255; $i++) {
    write-host "192.168.0.$i"
}

$nums = 1,2,3,4,5
$nums | ForEach-Object{$_ * 2}
    #outputs 2,4,6,8,10
    
ForEach ($item in gci C:\ -recurse){$item.name}
    #for each loops must complete the whole expression before moving to the condition
    

###while loops
$var = ""
while($var -ne "Marines") {
    $var = Read-host "Which branch be the best"
}

$num=0
do {
  $num
  $num++
}while($num -lt 3)

$num=0
do {
  $num
  $num++
}until($num -lt 3)
    #difference between until and while is that until will include three cause it returns the value it ended on

###Flow Control
$num = 0
while($num -lt 10) {
    $num += 1
    if ($num -eq 5) {
        break
    }}
$num

###Hash Tables
#can have arrays inside as a value for a key in a hash table
#below creates a hash table
$mylist = @{First = "John"; Last = "Doe"; mid = "Bon"; Age = "35"}
#to call them 
$mylist.First
$mylist["Last"]

$mylist.Keys  #gives you all the keys you have to call on

$mylist.values  #gives you all the values you could call for

$mylist.<new key> = <new value>   #how to add on items to a hash table post creation

##########################################################################################################################################################

                                                                        #Day 3#

##########################################################################################################################################################

###String Manipulation

$text1 = "One Terabyte is $(1TB / 1GB) Gigabytes"         #double quotes allow you to do the math shit inside and return the end value

##Special Characters
`n      #Newline Character
`t      #tabulator (tab)
`b      #Backspace Character
`'      #Single Quotation Mark
`"      #Double Quotation Mark
`0      #Null
 ``     #Backtick character

##String Operators


"{0:n3}" -f 123.45678         #takes the 123.45678 and then returns it with only 3 decemal places

"{0:d5}" -f 123               #00123 (pads with 0s to make 5 digits)

get-service | select-object -first 10 | foreach-object{"The Service is call '{1}': {2}"-f $_.name, $_.Displayname, $_.status}
      #takes output from get-service, shos first 10 lines, and then takes those 10 and outputs "The Service is call <display name>: <Status>"
get-process | select-object -first 5 | foreach-object{"Process {1} is {0}" -f $_.Name, $_.sessionid}
      #takes the output from get-process, shows only first ive, then takes those first five and returns "Process <sessionid> is <Name>"


#with replace you put what your replacing first then what its eig replaced with second
"Hello John" -replace "John", "World"                                         #"Hello World"
'[        Jon           Bon         Doe       ]' -replace '\s+', " "          #[ Jon Bon Doe ]



##split

$profile -split '\.'                                      #splits $profile on the . character
##Output of above
C:\Users\student\Documents\WindowsPowerShell\Microsoft
PowerShellISE_profile
ps1

$profile -split '(?=\.)'                                  #(?=\.) tells it to keep the . after splitting on it
##Output of above
C:\Users\student\Documents\WindowsPowerShell\Microsoft
.PowerShellISE_profile
.ps1

'GetHostByName' -csplit '(?<=[a-z])(?=[A-Z])'             #splits on case sensitive
##Output of above
Get
Host
By
Name


###Join
"cat","dog","mouse" -join " "                             #cat dog mouse (joined the strings into one with a space in between each

$env:username, '@', $env:computername, ".", $env:userdomain -join ""      #student@WIN-OPS.WIN-OPS

.ToUpper()
.ToLower()
.split()
.join()
.startswith()
.endswith()

if ("10.12.14.300" -as [ipaddress]){"This is an IP Address"}              #as [ipaddress] tests to see if input is a valid ip address and if no return it is invalid

if ("10.12.14.155" -as [ipaddress]){"This is an IP Address"}              #returns "This is an IP Address" cause is valid ip unlike first

if ((Read-Host -prompt  "Please enter an IP Address") -as [ipaddress]){"This is an IP Address"} else {"This ain't an IP"}
      #script to take an inputed ip and tell if it is valid

###Functions

function <name> {
      <code to execute>                           #Basic Function Syntax
}

function test-it {
    write-output "Hello World"
}
test-it                                          #calling function


function <name>(<arguments>){
    <code to execute>                            #basic syntax for function that takes specific arguments
}

function test-it2($value){
    if ($value) {
      write-host -foregroundcolor Cyan "True"
    }
    else{
      write-host -foregroundcolor Red "False"
    }
}
            #function so that if just run will return false in red, but if run like (test-it2 <some shit>) will return True in cyan
            
function <name>{
    param(
      <param variable>,<param variable>
    )                                              #Basic syntax for a function that takes parameters
    <code to execute>
}



function test-func{
  param(
      $param1='Default Value 1', $param2='Default Value 2'
  )
  "You Entered $param1 and $param2"
}
          #will return "You Entered Default Value 1 and Default Value 2" unless you give it something when calling the function


function <name>{
    param(
        [switch]
        <param variable>
    )                                              #Basic syntax for a function with switch parameter
    <code to execute>
}


function Do-Switch{
    param(
      [switch]
      $DoSwitch
    )
    if ($DoSwitch) {
        "Switch is Done"
    }
    else {
        "Switch is Off"
    }
}

Do-Switch -DoSwitch                                #how to run with switch on (calling the switch parameter with -DOSwitch)
Do-Switch                                          #will return switch is off cause not using switch parameter

function <Name> {
    param(
      [Parameter(Mandatory=$true)]
      <param name>
    )                                              #basic syntax of a function with a mandatory parameter
    <code to execute>
}

function test-mandatoryparam {
  param(
    [Parameter(Mandatory=$true)]
    $name
  )
  "Your Name is $name"
}
      #if try to run without giving value once enter is hit it will prompt you saying need to enter and then once entered it will continue

function test-mandatoryhelp {
  param(
    [Parameter(Mandatory=$true, helpmessage="What is your name?")]
    $name
  )
  "Your Name is $name"
}

      #now if try to run without value it wll give a prompt for how to get help message if need help
      
function Convert-ToDollars{
    param(
      [Parameter(Mandatory=$true, HelpMessage="Please enter a number of euros")]
      [Double]$euro
    )
    $dollar = $euro * 1.09
    "{0:n2}" -f $dollar
}


      #basic function that will convert a number of euros into its equivilant in dollars

##Advanced Functions

Function <name> {       #basic syntax for an advanced function
Begin{
  <code>                #Creates Variables and set the environment for a process block.  If this one exists end block is req
}
Process{
  <code>                #process block is functionally equivilant to a foreach-object loop
}
End{
  <code>                #usually gives the output of the function after all pipeline objects have been processed
}
}

function add-nums {
    param(
        [Parameter(Mandatory=$true)]
        [int]$var1,
        [Parameter(Mandatory=$true)]
        [int]$var2
    )
    Begin{
      $sum = 0
    }
    Process{
      $sum = $var1 + $var2
    }
    End{
      $sum
    }
}

###Function Review

Function Show-Args{
    $args[0]
    $args[1]
    $args[2]
}

Function enum-input{
    $input | foreach-object{$_ * 4}
}
### pipe data into function to run

Function process-input{
Begin{
    $counter = 0
}
Process{
    $_ * 4
    $counter++
}
End{
    $counter
}
}








