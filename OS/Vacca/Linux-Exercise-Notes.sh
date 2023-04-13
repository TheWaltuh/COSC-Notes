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














