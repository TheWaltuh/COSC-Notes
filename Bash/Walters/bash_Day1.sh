-------------BASH DAY 1--------------


curl -- download data from a web server

! -- is an alias for histroy.
!### -- rerun a command by refrenceing its number in history
!! -- rerun last command.

ctrl+E -- jump to end of line
ctrl+L -- clear screen


--------man pages functions--------
use / to search for things in the page
man bash -- opens bash man page
G -- move to end of man page
g -- move to start of man page

/ serach for nth matching line
? search backward for nth mathcing line
& display only matching lines
n or shift+n move between matches
q quit man page


explainshell.com -- website that can explain what a shell command does. 



___________ORDER OF EVALUATION_____________


redirection -- use the | character to redirect the output of one command to the 
		input of another.
	    -- use the > character to output the result of a command to a file. will overwrite 			contents of file.
	    -- use the >> characters to append the result of a command to a file. 
    
	    
alias -- command to display all aliases. 
      -- aliases are stored in your current session in bash
      -- exception is when you put functions into your .bashrc file.
      

parameter expansion, command substitution, arithmetic expansion and quote removal

Hash Tables - 

$PATH variable - where your computer looks for commands to run. 

Error - (command not found.)





-----------------file system manipulation-----------------------
touch makes a file.
touch -t manipulates a file's timestamp
rm -r is a recursive remove.
rmdir is to remove a directory. 
	brace expansion: EXAMPLE - 
	touch file{1..5}.txt
	 -- will create file1.txt, file2.txt, file3.txt... etc.
	 -- if you use commas it will run through it like a list.
	touch file{1,5,9}.txt
	-- will create file1.txt, file5.txt, file9.txt.
file will tell you what kind of file something is.

absolute file path is the full path, starting from the root. 
relative file path is the path from your current working directory. 
forward slash "/" represents the root of the file system.
"~" represents the current user's home directory. usually "/home/$USER"

wildcard is *

find -- use the find command to get a file. 

use the -perm option to find a file with certain permissions. 

-name makes it case sensitive

-iname makes it case insensitive

-type can let me look for a certain kind of file.

-mtime (modified time) -ctime (changed time) lets me look for files based on changed or modified time

-exec will execute a command 
EXAMPLE:
find -executable -exec wc -l {} \;
**this will find all executable files, then execute the wc command and return the files and their
wordcounts**

-printf print the output in a certain way:
EXAMPLE:
find -empty -printf "%i\n"

** will print the inode (%i) of the file followed by a newline
-path will tell find where to start searching.



whereis -- use the whereis file to find the location of a binary/command

locate -- searches databse for linux native commands




--------processes and memory---------
process hirearchy-
KERNEL
  L__________Init -01
                 L____________BASH
              
ps -- process snapshot
      try the -forest option to see what came from what.
	
kill -- kill a process by pid
pkill -- likk a process by name

-------------viewing files--------------
cat -- just prints everything out.
less -- shows you contents one page at a time. *most user friendly. LESS SHOWS YOU MORE
more -- just shows you the top and the percentage of the file you're seeing.

head -- pulls 10 lines (by default) from the top of the file
tail -- pulls 10 lines (by default) from the end of the file




grep [pattern to find] [file to search]
-i makes the search case insensitive
-n shows the line number
-C5 shows 5 lines before and after the match. Number can be replaced. 
-A5 shows lines after
-B5 shows lines before
-v shows everything that is NOT your search pattern
-E lets us search with regex (could also use egrep)


cut -- cuts out sections of a file. 
-d delimiter
-f fields 1-indexed
-c characters
-s won't include non-delimited lines.
EXAMPLE:
tail passwd | cut -d: -f6
** will show the 6th field of /etc/passwd, delimited by the ":" characters




%%%%%%%%%%%%%EXERCISES%%%%%%%%%%%%%%%%%%
use brace expression to create files. Don't forget, you may need to create the directory and specify the path.

touch $HOME/1123/{1..5}.txt $HOME/1123/{6..9}~.txt



Using find, list all files in %HOME/1123 that end in .txt.
mkdir $HOME/1123
find 1123/*.txt



find all files with .txt in the directory except ones that have the ~ character.

find *.txt | grep -v "~"




Using only find and cp, copy only the files without the ~ to a new directory. 

find -regextype egrep -regex '.*/[1-9].txt' -exec cp {} /cut/ \;

****NOTE****  Why was the regex weird? \d was not working. 




Using only find, find all empty files in /var and print their inode and filename without leading directories. 

find /var -empty -printf '%i %f\n'

NOTE: %f is the filename without leading directories, %i is the inode. There are many more of these kinds of variables in the man pages. 



find all files from root with this inode and return just the filename with no full path.

find -inum 999 -printf '%f\n'



print all files with extensions into a text file

ls -l $HOME/CUT/*.txt --ignore=names.* | cut -d' ' -f9 | cut -d'/' -f3 > $HOME/CUT/names

























