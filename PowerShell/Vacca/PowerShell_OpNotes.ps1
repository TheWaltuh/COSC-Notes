#---------------------------------------------------------------------------------------------

#Practical Exercise: Find Cmdlets

#    Ensure that you have the latest copy of help by updating your help system.

update-help -Force -ErrorAction silentlycontinue

#    Which cmdlets deal with the viewing/manipulating of processes?

get-command *process*
get-help *process*
get-process

#    Display a list of services installed on your local computer.

Get-Service

#    What cmdlets are used to write or output objects or text to the screen?

write-host
write-output

#    What cmdlets can be used to create, modify, list, and delete variables?

New-Variable
Set-Variable
Get-Variable
Remove-Variable

#    What cmdlet can be used, other than Get-Help, to find and list other cmdlets?

Get-Command

#    Find the cmdlet that is used to prompt the user for input.

Read-Host

#---------------------------------------------------------------------------------------------

#Practical Exercise: Running Cmdlets

#    Display a list of running processes.
    
Get-Process

#    Display a list of all running processes that start with the letter "s".

Get-Process -name "S*"

#    Find the cmdlet and its purpose for the following aliases:
    
    get-alias -name gal,dir,echo,?,%,ft

        gal     get-alias

        dir     get-childitem

        echo    write-output

        ?       Where-Object

        %       ForEach-Object

        ft      Format-Table

#    Display a list of Windows Firewall Rules.
    
    get-command -ver "Get" -noun "*firewall*"

Get-NetFirewallRule

#    Create a new alias called "gh" for the cmdlet "Get-Help"

set-alias gh get-help

#---------------------------------------------------------------------------------------------

#Practical Exercise: Variables

#    Create a variable called "var1" that holds a random number between 25-50.

$var1 = (Get-Random -minimum 25 -maximum 50)

#    Create a variable called "var2" that holds a random number between 1-10.

$var1 = (Get-Random -minimum 1 -maximum 10)

#    Create a variable called "sum" that holds the sum of var1 and var2.

$sum = $var1 + $var2

#    Create a variable called "sub" that holds the difference of var1 and var2.

$sub = $var1 - $var2

#    Create a variable called "prod" that holds the product of var1 and var2.

$prod = $var1 * $var2

#    Create a variable called "quo" that holds the quotient of var1 and var2.

$quo = $var1 / $var2

#    Replace the variables in text with their values in the following format:

        "var1" + "var2" = "sum"

write-host "$var1" + "$var2" = "$sum"
"{0} + {1} = {2}" -f $var1,$var2,$sum

#    Replace the variables in text with their values in the following format:

        "var1" - "var2" = "sub"

write-host "$var1" - "$var2" = "$sub"
"{0} - {1} = {2}" -f $var1,$var2,$sub

#    Replace the variables in text with their values in the following format:

        "var1" * "var2" = "prod"

write-host "$var1" * "$var2" = "$prod"
"{0} * {1} = {2}" -f $var1,$var2,$prod

#    Replace the variables in text with their values in the following format:

        "var1" / "var2" = "quo"

write-host "$var1" / "$var2" = "$quo"
"{0} / {1} = {2}" -f $var1,$var2,$quo

#---------------------------------------------------------------------------------------------

#Practical Exercise: The Pipeline

#    Display the start time of the earliest and latest running processes

        (Get-Process).StartTime | sort-object |Select-Object -First 1 -Last 1

#    Identify a cmdlet that returns the current date and time then using this cmdlet and Select-object, display only the current day of the week

        get-date | Select-Object -Property DayOfWeek

#    Identify a cmdlet that displays a list of installed hotfixes.

        Get-Hotfix

#    Extend the expression to sort the list by install date, and display only the install date and hotfix ID.

        get-hotfix | Select-Object -Property InstalledOn,HotfixID | sort-object -property InstalledOn

#    Extend the expression further, but this time sort by description, include description, hotfix ID, and install Date.

        get-hotfix | Select-Object -Property Description,InstalledOn,HotfixID | Sort-Object -Property Description


#Practical Exercise: Custom Object

#    Create a custom object that contains information about the host system using the following:

#        Win32_ComputerSystem

#        Win32_BIOS

#        Win32_OperatingSystem

#        Win32_LogicalDisk
        


#    Use the cmdlet Get-WmiObject to obtain the needed information


$SystemInformationlol = [PSCustomObject]@{
"ComputerName" = (Get-WmiObject -Class win32_computersystem | select-object -ExpandProperty Name)
"Operating System" =  ((Get-WmiObject win32_operatingsystem).name)
"Version" = ((Get-WmiObject win32_operatingsystem).version)
"Manufacturer" = ((Get-WmiObject win32_operatingsystem).manufacturer)
"Disks" =  (Get-WmiObject -Class win32_logicaldisk).__Path
}

#---------------------------------------------------------------------------------------------

#Practical Exercise: Comparison and Condition

#    Find and extract the model number from the provided lines of text. If there isn’t a model number then display to the user that a model number wasn’t found

#    Check both lines for model numbers and report individually the line and model number if found.

$line1 = "Do you have model number: MT5437 for john.doe@sharklasers.com?"
$line2 = "What model number for john.doe@sharklasers.com?"
switch($papttern){
    {$line1 -match $_ | out-null} {
        }
    {$line2 -match $_ | out-null} {
        }
    {$line1 -notmatch $_} {
        }
    {$line2 -notmatch $_} {
        }
}


#---------------------------------------------------------------------------------------------

#Practical Exercise: Looping & Iteration

#    Part 1

#        Use an array to iterate and open the following

#            Notepad

#            MS Edge

#            MSpaint

#        Query the processes

#        Kill the processes from PowerShell

$appstoopen='Notepad','MSEdge','MSpaint'

foreach ($item in $appstoopen) {
Start-Process $item
Get-Process $item
Stop-Process -name $item
} 



#   Part 2

#        Use an array to iterate and open the following

#            Notepad

#            MS Edge

#            MSpaint

#        Query the processes

#        Save the ProcessIDs to a text file called procs.txt

#        Iterate through the ProcessIDs in the text file and kill them

$appstoopen='Notepad','MSEdge','MSpaint'

foreach ($item in $appstoopen) {
Start-Process $item
Get-Process $item
(Get-Process $item).id | Where-Object {$item.name -ne "Idle"} >> procs.txt
}

$a=(get-content .\procs.txt)

foreach ($i in $a) {
Stop-Process -id $i
} 



#    Part 3

#        Use an array to iterate and open the following

#            Notepad

#            MS Edge

#            MSpaint

#        Query the processes and display only the following information in order by process ID

#            Process ID

#            Process Name

#            The time the process started

#            The amount of time the process has spent on the processor

#            The amount of memory assigned to the process

 $appstoopen='Notepad','MSEdge','MSpaint'

foreach ($item in $appstoopen) {
Start-Process $item
Get-Process -Name $item | Select-Object -Property id,name,StartTime,TotalProcessorTime,WorkingSet64
Stop-Process -name $item
}
 
 #Practical Exercise: Create Functions

#   Write a function that returns the Ordinal date of the current date.

function OrdinalDate {
    $a=(get-date).Year
    $b=(get-date).DayOfYear
    $a, $b -join "-"
}

#   Create a function that takes a number(n) as an argument and returns the square(n^2) of the number.

function Get-SquareNum ($num) {
   "$($num * $num)" 
}

#   Create a function that takes three (3) arguments and returns the product of the arguments.

function Get-Product ($num1, $num2, $num3) {
   "$($num1 * $num2 * $num3)"
}

#Practical Exercise: Function Parameters

#    Create a function that takes two(2) integer values, $a and $b, that are the lengths of two(2) legs of a right triangle and returns the length of the hypotenuse.

function Pythagorean ($a, $b) {
   $hypotenuse=[MaTh]::sqrt(($a*$a)+($b*$b))
   $hypotenuse
}

#Create a function that takes two(2) values, $a and $b, as two(2) angles in degrees of a triangle. Return the value of the missing angle.

function eq180 ($a, $b) {
(180 - ($a + $b))
}



#    Create a function that takes the following as mandatory parameters:

#        First Name

#        Last Name

#        Age

#        Weight in pounds(lbs)

#and returns the information in a hash table using the keys: first, last, age, and weight with the weight value converted to kilograms(kg) rounded to the nearest whole number

function person {
    param(
        [Parameter(Mandatory)]
        $FirstName,
        [Parameter(Mandatory)]
        $LastName,
        [Parameter(Mandatory)]
        $Age,
        [Parameter(Mandatory)]
        [int]$Weight )
    $kilos = ($weight * 0.453)
    
    $data = @{
    "First" = $FirstName
    "Last" = $LastName
    "Age" = $Age
    "Lbs" = $weight
    "Kilos" = $kilos
    }
    $data
}

#Practical Exercise: Advanced Functions

#    Create an advanced function using Begin, Process, and End, that takes two(2) arguments. The first argument being an array of at least ten(10) integers and the second argument being a single integer. Search the array argument for every occurrence of the single integer argument then return the sum of all elements in the array excluding every occurrence of the single integer argument.

function get-multisum ($arg1,$arg2){
begin{
$sum=0
}
process{
foreach ($i in $arg1) {if ($i -ne $arg2 ){$sum += [int]$i }}
}
end{
$sum
}
}

#Create an advanced function using Begin, Process, End, that prompts the user to enter the names of three(3) U.S. States then returns the names of the states in the order of longest name to shortest name and the amount of characters in each name.

function Get-LongestName{
begin{
    $state1=(read-host -prompt "Enter the name of a state")
    $state2=(read-host -prompt "Enter the name of another state")
    $state3=(read-host -prompt "Enter the name of another state")
}
process{
    $state1Len=("$state1`: " + $(($state1 -replace '\s',"").length))
    $state2Len=("$state2`: " + $(($state2 -replace '\s',"").length))
    $state3Len=("$state3`: " + $(($state3 -replace '\s',"").length))
    $LongestToShortest = (($state1Len,$state2Len,$state3Len) | Sort-Object -Property Length -Descending)
}
end{
    $LongestToShortest
}
}
