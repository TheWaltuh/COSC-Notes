#Linux Basics LFS Hierarchy6

#What is the absolute path for the binary cat man-page?

whereis cat           #shows the cat binary and cat man page

#Search the man pages for the keyword digest. Then, use one of the binaries listed to hash the string OneWayBestWay using the largest sha hash available.

#The resulting hash is the flag.

man -k digest         #finds commands that the man page conatins the string digest
echo "OneWayBestWay" | sha512sum  #Gets a hash of the string

#Linux Basics 6

#Use File: /home/garviel/Encrypted

#This file contains encrypted contents. Identify its file type, then decode its contents.

#Hint: Use OpenSSL

flie Encrypted          #file was zipped
unzip Encrypted
openssl enc 0d -aes-128-cbc -in cipher    #decrpts with the password in the other file contained in the zip

#Linux Basics LFS Hierarchy7

#Search the user home directories to find the file with the second-most lines in it. Hint: Exclude the VDI file! The flag is the number of lines in the file.

find /home/ -type f -exec wc -l \;

#Linux Basics Users and Groups1

#Read the file that contains the user database for the machine. Identify a strange comment.

cat /etc/passwd | head -10 | awk -F: '{print $5}'

#Linux Basics Users and Groups2

#Identify all members of the lodge group. List their names in alphabetical order with a comma in between each name.

#Flag Format: name,name,name

cat /etc/group | grep lodgeclear

#Linux Basics Users and Groups3

#Find the user with a unique login shell.

cat /etc/passwd | awk -F: '{print $NF}' | sort -u

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

#Linux Basics Permissions7

#Identify the file within /media/Bibliotheca where the owning group has more rights than the owning user.

find /media/Bibliotheca/ -perm -u+r ! -perm -g+r

#inux Basics Permissions8

#xecute the file owned by the guardsmen group in /media/Bibliotheca, as the owning user.

#The flag is the code name provided after a successful access attempt.

find /media/Bibliotheca/ -group guardsmen                   #find the file
ll /media/Bibliotheca/Bibliotheca_quattuor/Tactica_Imperium #find the owner
sudo -u gaunt /media/Bibliotheca/Bibliotheca_quattuor/Tactica_Imperium  #flag

#Linux Basics Permissions4

#The user tyborc is unable to access the directory:

#/media/Bibliotheca/Bibliotheca_unus

#Why? Identify the permission missing in standard verb form.

ll /media/Bibliotheca/Bibliotheca_unus      #missing perm is execute on others

#Linux Basics Permissions6

#You only have a single submission attempt for this challenge.

#Locate the file in /media/Bibliotheca that Inquisitor Quixos has sole modification rights on.

#The flag is the absolute path for the file.

find /media/Bibliotheca/ -user quixos
ll <each>             #one had only user

#Linux Basics Permissions9

#Read the concealed file within /media/Bibliotheca

find /media/Bibliotheca/ -type f -iname *.* -ls

#inux Basics Permissions10

#Find the warp and read its secrets for the flag.

find /media/Bibliotheca/ -type f -iname *.* -ls

#Linux Basics Regular Expressions1

#Using the commands ls and grep, identify the number of directories in /etc/ that end in .d

ls -a /etc | egrep -c "*\.d$"

#Linux Basics Regular Expressions2

#File: home/garviel/numbers

#Use regular expressions to match patterns similar to an IP address.

#The answer is the count/number of lines that match in the file.

 egrep -c '^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$' ./numbers
 
 Linux Basics Regular Expressions3
10

#File: home/garviel/numbers

#Use regular expressions to match valid IP addresses. The flag is the number of addresses.

#HINT: What are the valid numerical values of each octet in an IP address?

egrep -c '(\b25[0-5]|\b2[0-4][0-9]|\b[01]?[0-9][0-9]?)(\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)){3}\b' ./numbers

#Linux Basics Regular Expressions4

#File: home/garviel/numbers

#Use regular expressions to match patterns that look similar to a MAC Address. Flag is a count of the number of matches.

#HINT: This is a loose match! Some of these results won't be true MAC addresses.

#Flag format: ####

egrep -c '^([0-9A-Za-z]{2}[-]){5}([0-9A-Za-z]{2})$' ./numbers

#Linux Basics Reformat1

#File: home/garviel/numbers

#Use awk to print lines:

#>= 420 AND <=1337

#The flag is a SHA512 hash of the output.

echo "$(awk 'NR==420, NR==1337' numbers)" | sha512sum

#Linux Basics Reformat2

#File: home/garviel/connections

#Use awk to create a separate CSV (comma separated value) file that contains columns 1-6.

#The flag is an MD5 hash of the new file

#Hint: Look at #fields on line 6 in the file to understand column layout.

#Hint: This is a Zeek (formally known as Bro) connection log file in TSV format. Click This Link to learn about its formatting.

awk '{OFS=","}{print $1,$2,$3,$4,$5,$6}' connections > awkedconnections   #format the file
vim       #match the header
md5sum awkedconnections

#Linux Basics Bash Logic2

#The flag resides in $HOME/paths... you just need to determine which flag it is. The flag sits next to a string #matching the name of a $PATH/binary on your system.

#Hint: The correct binary is not echo

ls /usr/bin | awk '{print $NF}' > bins.txt    #all user binarys
ls /bin | awk '{print $NF}' >> bins.txt       #all binarys
cat paths | awk '{print $1}' > paths.txt      #just names from paths file
grep -w -Ff "bins.txt" "paths.txt"            #search one file for everything in another
grep python3 paths                            #find flag

#Linux Basics Regular Expressions5

#File: home/garviel/numbers

#Use regular expressions to find valid Locally Administered or Universally Administered Unicast MAC addresses.

#Give the count of Locally and Universally Administered MAC addresses as the answer.

#HINT: What characters specifically define a Locally or Universally Administered Unicast MAC Address?

egrep "^([0-9A-Fa-f][02468ACE][:-]){1}([0-9A-Fa-f]{2}[:-]){4}([0-9A-Fa-f]{2})$" ./numbers | wc -l

#Linux Basics Bash Logic3

#FILE: /home/garviel/Inquisition_Targets

#Identify heresy by comparing the Inquisition_Targets file to members of the Guardsmen group.

#HINT: Reformat and clean up the data before it is compared. awk and sort are your best friends!

#The flag is the number of heretics on the system.

cat /etc/group | grep guardsmen > lists.txt
echo "$(tr , "\n" < lists.txt)" > lists2.txt
grep -w -Ff "Inquisition_Targets" "lists2.txt"


