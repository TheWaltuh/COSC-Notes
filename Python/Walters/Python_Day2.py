
Day 2 Notes

Boolean logic operators:
and -- logical and
or -- logical inclusive or
in -- use against a list/tuple, returns bool value based on if the value is in the subject. Syntax: 10 in myList


while loops and for loops

while loop runs until condition is false

for loop uses an iterable and an iterator

list[start:stop:step], just like the range() function

Exercise 1: FIZZBUZZ

usrinput = int(input("number: "))

if usrinput%5 == 0 and usrinput%3 == 0:
    print("fizzbuzz")
elif usrinput%5 == 0:
    print("buzz")
elif usrinput%3 == 0:
    print("fizz")
else:
    print(usrinput)



Exercise 2: Categorize the numbers into negative/positive and even/odd.

usrin = int(input("number: "))


if usrin == 0:
    print("Zero")

elif usrin != 0:
    if usrin%2 == 0:
        if usrin > 0:
            print("Positive Even")
        elif usrin < 0:
            print("Negative Even")
    elif usrin % 2 != 0:
        if usrin > 0:
            print("Positive Odd")
        elif usrin < 0:
            print("Negative Odd")


Exercise 3: Guess the number program

def guess_number(n):
    while True:
        userinput = int(input("Guess: "))
        if userinput == n:
            print("WIN")
            break
        elif userinput > n:
            print("too high")
        elif userinput < n:
            print("too low")
    
guess_number(23)



Exercise 4: REVERSE IT. return the user's strings reversed.


def reverseit():
    inputs = []
    while True:
        userinput = input("Type Here: ")
        if userinput == "":
            print(inputs)
            return inputs
            
        inputs.append(userinput[::-1])
        
        
        
Exercise 5: LEETSTRING -- print alternating uppercase and lowercase

def leetString(s):
    newstring = []
    for i in range(0, len(s)):
        if i%2 == 0:
            newstring.append(s[i].upper())
        else:
            newstring.append(s[i].lower())
    return "".join(newstring)
    
    
    







