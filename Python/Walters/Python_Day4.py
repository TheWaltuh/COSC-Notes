
Python Day 4

_______________DICTIONARIES____________________

initialize with:
mydict = {
	KEY:VALUE,
	KEY:VALUE,
	KEY:VALUE
	}
	
call the values in a dictionary using:
mydict[KEY] ------ returns the value for that key.




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

