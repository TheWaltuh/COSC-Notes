
Practical Exercise: Find Cmdlets

    Ensure that you have the latest copy of help by updating your help system.

update-help -Force -ErrorAction silentlycontinue

    Which cmdlets deal with the viewing/manipulating of processes?

get-process

    Display a list of services installed on your local computer.

Get-Service

    What cmdlets are used to write or output objects or text to the screen?

write-host
write-output

    What cmdlets can be used to create, modify, list, and delete variables?

New-Variable
Set-Variable
Get-Variable
Remove-Variable

    What cmdlet can be used, other than Get-Help, to find and list other cmdlets?

Get-Command

    Find the cmdlet that is used to prompt the user for input.

Read-Host


Practical Exercise: Running Cmdlets

    Display a list of running processes.
    
Get-Process

    Display a list of all running processes that start with the letter "s".

Get-Process -name "S*"

    Find the cmdlet and its purpose for the following aliases:

        gal     get-alias

        dir     get-childitem

        echo    write-output

        ?       Where-Object

        %       ForEach-Object

        ft      Format-Table

    Display a list of Windows Firewall Rules.

Get-NetFirewallRule

    Create a new alias called "gh" for the cmdlet "Get-Help"

set-alias gh get-help


Practical Exercise: Variables

    Create a variable called "var1" that holds a random number between 25-50.

$var1 = (Get-Random -minimum 25 -maximum 50)

    Create a variable called "var2" that holds a random number between 1-10.

$var1 = (Get-Random -minimum 1 -maximum 10)

    Create a variable called "sum" that holds the sum of var1 and var2.

$sum = $var1 + $var2

    Create a variable called "sub" that holds the difference of var1 and var2.

$sub = $var1 - $var2

    Create a variable called "prod" that holds the product of var1 and var2.

$prod = $var1 * $var2

    Create a variable called "quo" that holds the quotient of var1 and var2.

$quo = $var1 / $var2

    Replace the variables in text with their values in the following format:

        "var1" + "var2" = "sum"

write-host "$var1" + "$var2" = "$sum"
"{0} + {1} = {2}" -f $var1,$var2,$sum

    Replace the variables in text with their values in the following format:

        "var1" - "var2" = "sub"

write-host "$var1" - "$var2" = "$sub"
"{0} - {1} = {2}" -f $var1,$var2,$sub

    Replace the variables in text with their values in the following format:

        "var1" * "var2" = "prod"

write-host "$var1" * "$var2" = "$prod"
"{0} * {1} = {2}" -f $var1,$var2,$prod

    Replace the variables in text with their values in the following format:

        "var1" / "var2" = "quo"

write-host "$var1" / "$var2" = "$quo"
"{0} / {1} = {2}" -f $var1,$var2,$quo

















