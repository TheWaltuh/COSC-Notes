

QUESTION 1:


QUESTION 2:retunr list with last n elements
def q1(lst, n):
    return lst[lst(len)-n


QUESTION 3: RETURN LIST OF ORDINAL NUMBERS
def q1(strng):
    returnstr = [*strng]
    for i in range(0, len(returnstr)):
        returnstr[i] = ord(returnstr[i])

    return returnstr
    
    
    
 QUESTION 4: RETURN lIST OF WORDS IN STRING AS A TUPLE
 def q1(strng):
    return tuple(list(strng.split()))

(['Long', 'sentence', 'to', 'test', 'the', "function's", 'capabilities'],)
('Long', 'sentence', 'to', 'test', 'the', "function's", 'capabilities')


QUESTION 5: RERTURN THE PRICE GIVEN THE QUANTITY AND ORDER OF THE PURCHACE

def q6(catalog, order):
    total = 0
    for i in range(0, len(order)):
        total += (catalog[order[i][0]]) * order[i][-1]        
    return total


QUESTION 6: RETURN THE LENGTH OF THE FIRST LINE

def q1(filename):
    with open(filename, "r") as f1:
        return len(f1.read().split()[0])
        
        

QUESTION 7: WRITE A LIST TO A FILE UNTIL YOU FIND "STOP"



QUESTION 8: RETURN PROPER GREETING BASED ON TIME

def q1(miltime):
    if miltime >= 300 and miltime <= 1159:
        return "Good Morning"
    if miltime >= 1200 and miltime <= 1559:
        return "Good Afternoon"
    if miltime <= 1600 and miltime <= 2059:
        return "Good Evening"
    if miltime >= 2100 or miltime <= 259:
        return "Good Night"
        
        
QUESTION 9: CHECK IF ALL NUMBERS IN A LIST ARE NEGATIVE

def q1(numlist):
    for num in numlist:
        if num >= 0:
            continue
        if num < 0:
            return False
    return True
    
    
    
    
    return min(len(x) for x in str.split())
    
    
