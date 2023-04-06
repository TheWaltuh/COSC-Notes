Practical Exercise: The Pipeline

1. Display the start time of the earliest and latest running processes
Get-Process | Select-Object -Property StartTime | Sort-Object StartTime | Select-Object -First 2 -Last 1

Get-Process | Where-Object{$_.StartTime} | Measure-Object -Property StartTime -Minimum -Maximum | Select-Object -Property Minimum, Maximum
#ALTERNATE WAY TO DO IT BY GETTING ONLY OBJECTS WITH A STARTTIME AND THEN GOING ABOUT FILTERING

2. Identify a cmdlet that returns the current date and time then using this cmdlet and Select-object, display only the current day of the week
Get-Date | Select-Object -Property DayOfWeek

3. Identify a cmdlet that displays a list of installed hotfixes.
get-HotFix

4. Extend the expression to sort the list by install date, and display only the install date and hotfix ID.
Get-HotFix | Select-Object -Property Hotfixid, InstalledOn | Sort-Object -Property InstalledOn

5. Extend the expression further, but this time sort by description, include description, hotfix ID, and install Date.
Get-HotFix | Select-Object -Property description, Hotfixid, InstalledOn | Sort-Object -Property description


Practical Exercise: Custom Object

1. Create a custom object that contains information about the host system using the following:

   - Win32_ComputerSystem

   - Win32_BIOS

   - Win32_OperatingSystem

   - Win32_LogicalDisk

$data = [PSCustomObject]@{
    ComputerName = ((Get-WmiObject -class Win32_ComputerSystem).Name)
    OperatingSystem = ((Get-WmiObject -class Win32_OperatingSystem).name)
    Version = ((Get-WmiObject -class Win32_BIOS).Version)
    Manufacturer = ((Get-WmiObject -class Win32_BIOS).Manufacturer)
    Disks = (Get-WmiObject -class Win32_LogicalDisk).__Path
}

2. Use the cmdlet Get-WmiObject to obtain the needed information

Practical Exercise: Comparison and Condition

1.Find and extract the model number from the provided lines of text. If there isn’t a model number then display to the user that a model number wasn’t found

$line1 = "Do you have model number: MT5437 for john.doe@sharklasers.com?"
$line2 = "What model number for john.doe@sharklasers.com?"
$pattern = 'MT(\d{4})'

switch($pattern) {
   {$line1 -match $_} {
      $line1 -match $pattern | out-null
      $mat = $matches[0]
      Write-Output "$Mat is the model number"
   }
   {$line2 -match $_} {
       $line2 -match $pattern | out-null
       $mat = $matches[0]
       Write-Output "$Mat is the model number"
   }
   
    {$line1 -notmatch $_} {
      $line1 -notmatch $pattern | out-null
      Write-Output "No model number was found in line 1"
   }
   {$line2 -notmatch $_} {
      $line2 -notmatch $pattern | out-null
      Write-Output "No model number was found in line 2"
   }}

2.Check both lines for model numbers and report individually the line and model number if found.
$line1 = "Do you have model number: MT5437 for john.doe@sharklasers.com?"
$line2 = "What model number for john.doe@sharklasers.com?"
$pattern = 'MT(\d{4})'

if ($line1 -match $pattern) {
    $mat = $matches[0]
    Write-Output "$Mat is the model number"
    write-output "Found in line 1"
}
else {
    Write-Output "No model number was found in line 1"
}

if ($line2 -match $pattern) {
    Write-Output "$Mat is the model number"
        write-output "Found in line 2"
}
else {
    Write-Output "No model number was found in line 2"
}




Part 1

1. Use an array to iterate and open the following

   - Notepad

   - MS Edge

   - MSpaint

   - Query the processes

   - Kill the processes from PowerShell

$arr = ("notepad", "MSEdge", "MSpaint")
for ($i=0; $i -lt $arr.length; $i++) {
    start-process $arr[$i]
    get-process $arr[$i]
    stop-process -name $arr[$i]
}

###Alternate way to do same thing (much simpler)
foreach($item in $arr) {
start-process $item
get-process $item
stop-process -name $item
}

Part 2

2. Use an array to iterate and open the following

   - Notepad

   - MS Edge

   - MSpaint

   - Query the processes

   - Save the ProcessIDs to a text file called procs.txt

   - Iterate through the ProcessIDs in the text file and kill them
   

$arr = ("notepad", "MSEdge", "MSpaint")
for ($i=0; $i -lt $arr.length; $i++) {
    start-process $arr[$i]
    get-process | Where-Object -FilterScript {$_.ProcessName -eq $array[$i]} | Select-Object Id | Out-File -FilePath C:\Users\student\Desktop\test.txt -Append
    stop-process -name $arr[$i]
}


$arr = "notepad", "MSEdge", "MSpaint"

foreach($item in $arr) {
start-process $item
get-process $item
(get-process $item).id | where-object {$item.name -ne "idle"} >> procs.txt
}
$cat = (get-content .\procs.txt)
foreach($line in $cat) {
stop-process -id $line
}

Part 3

3. Use an array to iterate and open the following

   - Notepad

   - MS Edge

   - MSpaint

   - Query the processes and display only the following information in order by process ID

   - Process ID

   - Process Name

   - The time the process started

   - The amount of time the process has spent on the processor

   - The amount of memory assigned to the process

$arr = ("notepad", "MSEdge", "MSpaint")
for ($i=0; $i -lt $arr.length; $i++) {
      start-process $arr[$i]
      get-process | Where-Object -FilterScript {$_.ProcessName -eq $array[$i]} | Select-Object Id,ProcessName,StartTime,TotalProcessorTime,PageMemorySize
}
   
###ALTERNATE AND SLIGHTLY MORE SIMPLE WAY TO DO IT
foreach($item in $arr) {
start-process $item
get-process $item | Sort-object ID | format-table -property ID, ProcessName,Starttime,TotalProcessorTime,VirtualMemorySize,Workingset64
stop-process -name $item
}

   
   
   
   
