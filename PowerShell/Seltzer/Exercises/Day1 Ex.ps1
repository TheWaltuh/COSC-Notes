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



Practical Exercise: Running Cmdlets

1. Display a list of running processes.
get-process

2. Display a list of all running processes that start with the letter "s".
get-process s*

3. Find the cmdlet and its purpose for the following aliases:

	a. gal
		get-alias -name gal
		Alias           gal -> Get-Alias 
	b. dir
		get-alias -name dir
		Alias           dir -> Get-ChildItem 
	c. echo
		get-alias -name echo
		Alias           echo -> Write-Output 
	d. ?
		get-alias -name ?
		Alias           ? -> Where-Object
	e. %
		get-alias -name %
		Alias           % -> ForEach-Object 
	f. ft
		get-alias -name ft
		Alias           ft -> Format-Table   

4. Display a list of Windows Firewall Rules.
show-netfirewallrule	 #shows all existing ipsec rules and associated objects in a fully expanded view
get-netfirewallrule 	 #retireves firewall rules from target computer
			 #get would be the better choice for this queston
5. Create a new alias called "gh" for the cmdlet "Get-Help"
Set-Alias gh Get-Help


Practical Exercise: Variables

1. Create a variable called "var1" that holds a random number between 25-50.
$var1 = get-random -minimum 25 -maximum 50 #once run the num will always be the same
					   #when setting $var1 is the only time the get-random is run (same goes for below command)

2. Create a variable called "var2" that holds a random number between 1-10.
$var2 = get-random -minimum 1 -maximum 10

3. Create a variable called "sum" that holds the sum of var1 and var2.
$sum = $var1 + $var2

4. Create a variable called "sub" that holds the difference of var1 and var2.
$sub = $var1 - $var2

5. Create a variable called "prod" that holds the product of var1 and var2.
$prod = $var1 * $var2

6. Create a variable called "quo" that holds the quotient of var1 and var2.
$quo = $var1 / $var2

7. Replace the variables in text with their values in the following format:

	a. "var1" + "var2" = "sum"
	write-host $var1 + $var2 = $sum
	
	write-output "$var1 + $var2 = $sum"
	
	"{0} + {1} = {2}" -f $var1,$var2,$sum
	#this is creates a formatted string with the nums in {} calling the vars at end in their places
	#is possible for all below questions

8. Replace the variables in text with their values in the following format:

	a. "var1" - "var2" = "sub"
	write-host $var1 - $var2 = $sub
	
	write-output "$var1 - $var2 = $sub"
	
	"{0} - {1} = {2}" -f $var1,$var2,$sub

9. Replace the variables in text with their values in the following format:

	a. "var1" * "var2" = "prod"
	write-host $var1 * $var2 = $prod
	
	write-output "$var1 * $var2 = $prod"
	
	"{0} * {1} = {2}" -f $var1,$var2,$prod

10. Replace the variables in text with their values in the following format:

	a. "var1" / "var2" = "quo"
	write-host $var1 / $var2 = $quo
	
	write-output "$var1 / $var2 = $quo"
	
	"{0} / {1} = {2}" -f $var1,$var2,$quo
