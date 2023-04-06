
-----------------BASH DAY 4-------------------


for loops
break and continue
while and until loops
activities 16-20


-----------------FOR LOOPS-------------------

iterate over a list of items and perform commands

SYNTAX:
for item in [LIST]
do
	commands
done

list can be a brace expansion, like so:

for item in {1..15}
do 
	echo $item
done
**will print 1-15.


---------------BREAK and CONTINUE----------------------

break -- terminate the current loop and pass program control to next statment.

continue -- go to the next iteration of a loop.



-------------WHILE and UNTIL LOOPS--------------------

while loop perform a set of commands while the condition evaluation is true.

Until loop will perform a set of commands until the condition becomes true. (as long as the condition is false.)

should be able to do the same thing with both. 


Syntax:

while [[ $counter -le 10 ]]
do
  echo $counter
  ((counter++))
done
echo "all done!"


until [[ $counter -gt 10 ]]
do
  echo $counter
  (($counter++))
done
echo "all done!"


--------------------DEMO loops.sh-----------------------------

#most basic for loop through a list
names () {
  for NAME in Jackman Maclean Rhodes
  do
    echo $NAME
  done
}
names


**loop through a list/variable
names2 () {
  names="Walker Vacca Rudnick"
  for NAME in $names
  do
    echo $name
  done
}
names2



**loop through a file with command substiution
FILE=$1
names3 () {
  for NAME in $(cat $FILE)
  do
    echo $NAME
  done     
}
names3

**same, but more practical

FILE=$1
names4 () {
  for USER in $(awk -F: '{print $1}' /etc/passwd)
  do
    echo $USER
  done
}

**for loop in a range of numbers using brace expansion
range () {
  for NUMBER in {1..5}
  do 
    echo $NUMBER
  done
}
range


**range that countes down
team_rocket () {
  for COUNT in {10..1}
  do
    echo $COUNT
    sleep 1
  done
  echo "Blast off bitch"
}
team_rocket


**C like for loop!!!
count_loop () {
  for ((i=1;i<=10;i++))
  do
    echo "$i is equal to $i"
  done
}

**we can use variables in this kind of for loop.

start=3
end=12

for((i=start;i<=end;i++))
do
  echo start
done

** NOTE you don't need to use the $ to call a variable in this kind of for loop!



show_break () {
 i=o
 for (( ;; ))
 do
   echo iteration: $i - to infinity and beyond
   ((i++))
 if [[ i -gt 9000 ]];then
   echo "ong so big"
   break
 fi
 done
}



**while loop
cents_or_dollars () {
  count=1
  while [[ $count -le 99 ]]
  do
    echo "$count make cents, right?"
    ((count++))
  done
  echo "$count makes a dollar"
}
cents_or_dollars



#until loop
autobots () {
  count=10
  until [[ $count -eq 0 ]]
  do
    echo $count
    ((count--))
  done  
  echo "done"
}


-----------------ACTIVITIES----------------------




Check if directory exists, if it does copy contents in to new directory

if [[ -e $HOME/.ssh ]];then
  cp -r $HOME/.ssh $HOME/SSH
else
  echo "Run ssh-keygen"
fi






ping an ip, return if the ping was successful or not. get your default route and the absolute path of the ping command.

Solution:
gateway=$(ip route | head -1 | egrep -o "([0-9]{1,3}\.){3}[0-9]{1,3}" | head -1)
pingloc=$(which ping)

response=$($pingloc -c 6 $gateway)
echo $response
if [[ "$response" =~ 100% ]];then
  echo "failure"
else
  echo "successful"
fi



make files, zip them, put them in a tar archive

SOLUTION:
mkdir $HOME/ZIP
echo '12345' | md5sum | cut -d' ' -f1 > $HOME/ZIP/file1
echo '6789' | md5sum | cut -d' ' -f1 > $HOME/ZIP/file2
echo 'abcdef' | md5sum | cut -d' ' -f1 > $HOME/ZIP/file3
cd $HOME/ZIP
zip -q -j $HOME/ZIP/file.zip file1 file2 file3
tar -zcf file.tar.gz file.zip





make users in a loop based on the usernames given. UID and GID are in a file in their home directory.

SOLUTION:
for name in LARRY CURLY MOE
do
  ids=$(cat $HOME/${name}.txt)
  head -1 $HOME/passwd | awk -F':' -v name=$name -v ids=$ids 'OFS=":" {$1=name;$3=ids;$4=ids;$6="$HOME/"name;$7="/bin/bash"}{print}' >> $HOME/passwd
  mkdir $HOME/$name
  echo $ids > $HOME/${name}.txt
done





get the octal value of every file in /etc, sort them, organize into greater than and less than 642

Solution:
perms=$(find /etc -type f 2>/dev/null -exec stat {} -c '%a' \;)
for file in $perms
do
        if [[ $file -le 640 ]];then
                echo $file >> low.txt
        fi      
        if [[ $file -ge 642 ]];then
                echo $file >> high.txt
        fi      
done

low=$(cat low.txt)
high=$(cat high.txt)
echo "Files w/ OCTAL Perm Values 642+:"
echo "$high" | sort | uniq -c | sort -nr
echo ""
echo "Files w/ OCTAL Perm Values 0-640:"
echo "$low" | sort | uniq -c | sort -nr
































