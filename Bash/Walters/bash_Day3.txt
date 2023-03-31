----------BASH DAY 3-----------



-------------parameters and variables--------------

variables are parameters set with a name. 
You cannot have any spaces on either side of the equal sign when declaring a var.

var="hello world!"


BASH SPECIAL PARAMETERS:
$# -- gives the number of arguments passed.
$0 -- name of the current script
$1, $2, $3, etc. -- refrence the given arguments positionally. 
$* -- see all arguments passed.
$? -- status of last command that executed.
$_ -- gives last argument provided to previous command
$$ -- gives PID of current shell
$- -- gives flags that are set


----------FUNCTIONS----------------

goal: break your code into reusable organized blocks. 

syntax:
// first declare the function
function example() {
echo "Hello, World!"
}

// now call the function
example



the case keyword compares the passed variable and compares it to the values in the parenteses.
use the read keyword to get user input.
EXAMPLE:
read userchoice
case $userchoice in
(1) echo one ;;
(2) echo two ;;
(3) echo three ;;
(*) echo other ;;
esac



VARIABLE SUBSTITUTION:

name="John"
echo "my name is $name"
echo "my name is ${name}n5" // will print "my name is johnn5"
echo "my name is ${name:0:2}" // will print "my name is jo", you can grab little bits of the strings. 

**Everything in single quotes '' is taken literally. There is no substitution or escape characters.





--------------CHALLENGES--------------


Find leading directories to all files with *.bin and print unique entries.

solution:
find ~ -name "*.bin" -printf "%h\n" | sort | uniq



take the 10th file from a list and get the md5sum of that file

Solution:
var=$(find /sbin /bin /usr/bin /usr/sbin -type f -executable | sort -n | sed -n '10p')
md5=($(md5sum $var))
echo $md5


get the last line of /etc/passwd and change it with positional arguments and append it to the file.

solution:
shell="/bin/bash"
username="$2"
id="$3"
home="/home/$2"
tail -1 $1 | awk -F':' -v "username=$username" -v "id=$id" -v "home=$home" -v "shell=$shell" 'OFS=":"{$1=username;$3=id;$4=id;$6=home;$7=shell}{print}' >> $1



get the md5 sum of the name of a home directory from the /etc/passwd file.

solution:
sort -n -t: -k4 /etc/passwd | sed -n '10p' | cut -d: -f6 | md5sum | cut -d'-' -f1





    Write a script which will find and hash the contents 3 levels deep from each of these directories: /bin /etc /var
    Your script should:
        Exclude file type named pipes. These can break your script.
        Redirect STDOUT and STDERR to separate files.
        Determine the count of files hashed in the file with hashes.
        Determine the count of unsuccessfully hashed directories.
        Have both counts output to the screen with an appropriate title for each count.

SOLUTION:

find /bin /etc /var -maxdepth 3 \( ! -type p \) 2>/dev/null > templist.txt

cat templist.txt | while read line
do
md5sum $line 2>>error.log 1>>output.log
done

output=$(wc -l output.log | awk '{print $1}')
error=$(grep -i "directory" error.log | wc -l | awk '{print $1}')

echo "Successfully Hashed Files: $output"
echo "Unsuccessfully Hashed Directories: $error"
























