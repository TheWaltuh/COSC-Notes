--------------DAY 2 NOTES-----------------


Overview of day 2:
- conditionals 
- command substitution
- commands
	-alias
	-sort
	-uniq
	-awk
	-sed
-activities 6-10



----------CONDITIONALS-----------------


-e -- file exists?
-f -- file exists and is a regualar file?
-d -- file exists and is a directory?
== -- string equality
-eq -- number equality
!= -- strings, not equal to

** use symbols to compare letters, 
   use letters to compare numbers

syntax:
if [ STATEMENT ];then
 command
 command
 command
elif [[ statement ]];then
else
 command
 command
fi

-------------COMMAND SUBSTITUTION------------------


var=$(COMMAND)
command $(command)


example:

name=Andrew
echo "hello $name"
output: hello Andrew


---------------COMMANDS-------------------------

alias -- view all alisases
alias vim='nano' -- would make an alias to change vim into nano
unalias vim -- would undo the previous alias
\egrep -- escapes the normal alias for that command. 
aliases are not persistent by default. They need to by loaded into .bashrc
**alias names cannot have escape or quoting characters.



sort -- sort content according to position on the ASCII table
sort -n -- sort contents numerically
sort -u -- sort content uniquely
sort -r -- sort reversed
sort -t' ' -- specify field seperator/delimiter
sort -k# -- sort on a column


uniq -- select content uniquely, must already be sorted
uniq -c -- select uniquely with a count
uniq -u -- display only lines without duplicates
uniq -d -- display only the duplicate lines. Opposeite of -u
uniq -i -- make it case insensitive


awk syntax:
awk [options] 'selection _criteria {actions}' input_file > output_file
awk -F: '{print $1}' -- displays the 1st field delimited by a ":"
awk '{print $2}' -- display 2nd field delimited by default by a space
awk -F: '($3 == 0) {print $1}' /etc/passwd
EXAMPLES:
egrep "root" /etc/passwd | awk -F: '{print $1}'
** will print the first field, delimited by the :

awk -f: '{/root|student/print $1}' /etc/passwd 
** will look for the pattern "root" and "student" in lines then will print the first field.

date | awk '{print $1,$2,$3,$NF}'
**$NF will always give the last field, NF stands for the number of fields
**$(NF-1) works to find the second to last and so on.

date | awk 'OFS="-"{print $1,$2,$3,$NF}'
**OFS stands for Field Seperator

nmap localhost | awk 'NF==3{print}'
** will only print lines where there are 3 fields
** the != also works as not equal to. 

awk -f: '/root/,/student/{print $1}' /etc/passwd 
** will print everythin between root and student

echo "python is better than bash" | awk '{$1="bash";$5="Python";print}'
**You can change what fields say. You can add fields as well. 

SUBJECT=Leaders
VERB=Inspire
Object=people
**now i could echo these variables and see their value.
echo "Managers manage equipment" | awk -v ss=$SUBJECT -v vv=$VERB -v oo=$OBJECT '{$1=ss;$2=vv;$3=oo;print}'
**You need to import bash variables into awk before you can use them.

cat -n {FILE PATH} | awk '$NR==10{print}'
** cat will add line numbers, and awk will only print the line with a 10 in it. NR is the first field



sed -- stream editor for filtering and transforming text
sed 's/abc/123' -- replace first occourence of abc in every line with 123
sed 's/abc/123/g' -- replace every occourrence of abc in every line with 123. g is for global
sed '/sus/d' -- delete the sus lines. output everything else.
sed -i 'expression' file.txt -- Inplace to make changes permanent in file.txt. Must be the first command and must specift the file path. 
EXAMPLES:
egrep "student" /etc/passwd | sed 's/student/instructor/'
** will replace the first instance of student with instructor. add g to the end to make it look for every instance. 

sed 's/student/instructor/g;s/1001/1337/g'
** can have multiple expressions by seperating them with a semicolon.

** if you use "/" in your sed command, you need to escape that character with a "\"

** when substituting, you can use any character as you SED delimiter. 

sed '/$PATTERN/d' 
** deletes whatever is in $PATTERN

sed -n '10p' 
** the p command prints only the 10th line. 




-----------------ACTIVITIES-----------------------


Take the IP addresses out of a long text file, sort them based on how many times they appear in the file.

Solution:
egrep "([0-9]{1,3}\.){3}[0-9]{1,3}" StoryHiddenIPs | sort | uniq -c | sort -r




find users with uid > 3 and with shell /bin/bash

solution:
awk -F: '$3>3&&/\/bin\/bash/ {print $1}' ~/passwd > $HOME/SED/names.txt




Find certain outputs from a command

solution:
dmesg | egrep "CPU|BIOS" | egrep -vi "usable|reserved" | awk '{for (i=2; i<NF; i++) printf $i " "; print $NF}'
dmesg | egrep "CPU|BIOS" | egrep -vi "usable|reserved" | cut -d] -f2-10




hash a password, and replace every password in a shadow file with that new password.

Solution:
var=$(openssl passwd -1 -salt bad4u -quiet Password1234)
awk -F: -v "var=$var" 'BEGIN {OFS=":"}{$2=var}{print}' $HOME/PASS/shadow.txt




take all the lines from passwd and put it into another file, but don't include lines that end with /bin/sh or /bin/false

solution:
sed '/\/bin\/\(false\|sh\)/d' $HOME/passwd > $HOME/PASS/passwd.txt







