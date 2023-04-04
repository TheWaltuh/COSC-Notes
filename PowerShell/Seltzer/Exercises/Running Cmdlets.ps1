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
