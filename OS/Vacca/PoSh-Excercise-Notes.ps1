#Windows_PowerShell_CimClasses1 

#PowerShell doesn't have a native cmdlet that will give you processor information (such as get-processor or get-cpu). Knowing this information might be necessary. What command would give you information about the system's processor?
#Flag is the full command

get-cimclass | where-object -Property CimClassName -like *processor*    #useful to search cimclasses
get-ciminstance -ClassName cim_processor

#Windows_PowerShell_Logic2

#What PowerShell command will allow for counting lines in a file, averaging numbers, and summing numbers?

measure-object

#Windows_PowerShell_Regex_1

#What PowerShell command searches for text patterns in a string?

select-string               #-pattern option to specify what to search for

#Windows_PowerShell_CimClasses2

#To complete this challenge, find the description of the Lego Land service.

Get-CimClass | Where-Object -Property CimClassName -like *service*    #To find the CimClass that sercies information is contained in
Get-CimInstance -ClassName CIM_service | Where-Object -Property Name -like *lego* | fl -Property *  #finds the object within the CIM-Service class that has lego in the name and lists all its properties

#Windows_PowerShell_Logic5

#Find the only line that makes the two files in the CTF user's Downloads folder different.

#Hint The flag is the string (not line number).

$file=(get-content .\old.txt)   
$file2=(get-content .\new.txt)                                    #creating variables equal to the contents
Compare-Object -ReferenceObject $file -DifferenceObject $file2    #displaying only the differences

#Windows_PowerShell_Logic6

#The password is the 21st line from the top, in ASCII alphabetically-sorted, descending order of the words.txt file.

#**Note: File Location - C:\Users\CTF\Desktop\CTF

Get-Content .\words.txt | sort -Descending | Select-Object -First 21 | Select-Object -Last 1

#Windows_PowerShell_Logic7

#Count the number of unique words in words.txt

#**Note: File Location - C:\Users\CTF\Desktop\CTF

Get-Content .\words.txt | sort -Unique | Measure-Object

#Windows_PowerShell_Regex_3

#Count the number of words, case-insensitive, with either a or z in a word, in the words.txt file

#    Note: File Location - C:\Users\CTF\Desktop\CTF
#    Hint: There are multiple "words" on each line.

Get-Content .\words.txt | Select-String -Pattern 'a|z' | Measure-Object -Word

#Windows_PowerShell_Logic8

#Use a PowerShell loop to unzip the Omega file 1,000 times and read what is inside.

#Note: Make sure you back up the .zip file to a different directory before attempting this challenge.

(1000..1) | % {Expand-Archive .\Omega$_.zip -force -DestinationPath C:\Users\CTF\Documents\ } 

#Windows_PowerShell_Profiles8

#Challenge only allows ONE attempt

#Malware is running in a PowerShell profile on the File-Server. Based on PowerShell profile order of precedence (what is read first), find the correct flag.

#The flag is the string after the #, without the preceding space.

get-content ($PROFILE).AllUsersAllHosts             #AllUsersAllHosts is read first and then wrote over if another profile exists


#Windows_Registry_Basics_12

#What is the value inside of the registry subkey that loads every time the "Student" user logs on?

Get-LocalUser | select name,sid     #find sid for the user
reg query HKU\S-1-5-21-1204278314-2763755555-735148208-1004\SOFTWARE\Microsoft\windows\currentversion\run

#Windows_Registry_Basics_15

#Figure out the manufacturer's name of the only USB drive that was plugged into this machine.

reg query HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Enum\USBSTOR

#Windows_Registry_Basics_16

#What suspicious user profile, found in the registry, has connected to this machine?

gci 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\ProfileList\'

#Windows_Registry_Basics_17

#What suspicious wireless network, found in the registry, has this system connected to?


gci 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\NetworkList\Profiles\'




#oops


#Linux Basics Users and Groups3

#Find the user with a unique login shell.

cat /etc/passwd | awk -F: '{print $NF " ### " $1}' | sort

#Linux Basics Users and Groups4

#Identify the algorithm, the amount of salted characters added, and the length of the hashed password in the file that stores passwords.

#Hint: Research 'padding'...

#Flag format: algorithm,#characters,#length

https://crypto.stackexchange.com/questions/22956/what-is-the-length-field-in-sha-512-padding
sudo cat /etc/shadow | awk -F: '{print $2}' | sort -u


#Linux Basics Permissions1

#Find the directory named Bibliotheca. Enter the absolute path to the directory.

sudo find / -type d  -name Bibliotheca

#Linux Basics Permissions2
#Identify the number of users with valid login shells, who can list the contents of the Bibliotheca directory.

ll /media     #find perms and group for bibliotheca
cat /etc/group | grep chapter   #gets users within the group than can access this dir

#Linux Basics Permissions5

#Locate the file within /media/Bibliotheca that is modifiable by the only user that is part of the Chapter group, but not part of the Lodge group.

#Hint: Not the hidden file...

cat /etc/group | egrep -i "chapter|lodge"     #tells us that the user is mephiston
cat /etc/passwd | grep mephiston              #gets us his UID
find /media/Bibliotheca/ -user mephiston -perm /u+w   #









