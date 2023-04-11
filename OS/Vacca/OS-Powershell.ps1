#
#
#
  write-host "Day 1!"
#-------------------------------------------------------------------------------------------------------------------
get-host                  #enumerates information about the host machine

  "Cim"
get-cimclass              #Newer suppported system information giver for microsoft (replacced get-wmiobject)
get-CimInstance           #get an instance of CIM
get-ciminstance Win32_Process -Filter 'name like "p%"'

get-executionpolicy   

$profile | get-member -MemberType NoteProperty | fl      #shows the profiles and their propertys in a list
#if a profile location is not in its default location then it is an anomoly




#-------------------------------------------------------------------------------------------------------------------

#-------------------------------------------------------------------------------------------------------------------

#-------------------------------------------------------------------------------------------------------------------

#-------------------------------------------------------------------------------------------------------------------

#-------------------------------------------------------------------------------------------------------------------

#-------------------------------------------------------------------------------------------------------------------
Get-ChildItem -Filter *.abc -Recurse | Select-String -Pattern '^(?=.*\bword1\b)(?=.*\bword2\b)(?=.*\bword3\b).*$'
Get-CimInstance -ClassName win32_service | Where-Object -FilterScript {$_.name -eq "legoland"}
Compare-Object -ReferenceObject $file -DifferenceObject $file2 -IncludeEqual

  
  
  
  
  
  
  
