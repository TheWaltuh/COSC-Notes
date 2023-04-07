
Python Day 3

Today is just exercises.

Exercise 1: seperate even and odd numbers

def evensandodds(first, last):
    evens = []
    odds = []
    for i in range(first, last + 1):
        if i%2 == 0:
            evens.append(str(i))
        else:
            odds.append(str(i))
    for num in evens:
        print(num)
    for num in odds:
        print(num)
    
evensandodds(1, 15)



Exercise 2: Return a list  of strings given by the user

def user_io():
    inputs = []
    while True:
        usrinput = input("Enter Here: ")
        if usrinput == "":
            return inputs
        inputs.append(usrinput)
        
print(user_io())





Everything else today is just on codewars. EASY DAY...





-----------------PYTHON FILE IO----------------

open a file with the with command because it automatically closes the file.

example:

with open("testfile.txt", "w") as file1:
	file1.write("This is an example of file IO\n")

the parameter "w" means write.
If that parameter is "a" then you can append.
If that paramenter is "r" then you can read.

NOTE: If you don't include a newline in the string you're writing to the file it won't include one for you.


example of reading a file:

with open("testfile.txt, "r") as file1:
	file1.read()
	
this will print out all of file1

.readlines will create a list instead of a long string, .read will only make a long string.
.writelines will write a string or a list just like readlines() or read() will




FILE IO EXERCISE: READ FROM INFILE AND WRITE TO OUTFILE WITH LINENUMBERS

def linenums(inpath, outpath):
    with open("{}".format(inpath),"r") as infile, open("{}".format(outpath),"w") as outfile:
        temp = ""
        infile.writelines(temp)
        length = len(temp)
        count = 0
        for line in infile.readlines():
            count += 1
            outfile.write("{} ".format(count) + line)
            
linenums("testfile.txt", "testfile2.txt")

























