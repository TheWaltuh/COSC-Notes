Practical Exercise: Variables

1. Create a variable called "var1" that holds a random number between 25-50.
$var1 = get-random -minimum 25 -maximum 50 #once run the num will always be the same
					   #when setting $var1 is the only time the get-random is run (same goes for below command)

2. Create a variable called "var2" that holds a random number between 1-10.
$var2 = get-random -minimum 1 -maximum 10

3. Create a variable called "sum" that holds the sum of var1 and var2.
$sum = $var1 + $var2

4. Create a variable called "sub" that holds the difference of var1 and var2.
$sub = $var1 - $var2

5. Create a variable called "prod" that holds the product of var1 and var2.
$prod = $var1 * $var2

6. Create a variable called "quo" that holds the quotient of var1 and var2.
$quo = $var1 / $var2

7. Replace the variables in text with their values in the following format:

	a. "var1" + "var2" = "sum"
	write-host $var1 + $var2 = $sum
	#write-output "$var1 + $var2 = $sum"

8. Replace the variables in text with their values in the following format:

	a. "var1" - "var2" = "sub"
	write-host $var1 - $var2 = $sub
	#write-output "$var1 - $var2 = $sub"

9. Replace the variables in text with their values in the following format:

	a. "var1" * "var2" = "prod"
	write-host $var1 * $var2 = $prod
	#write-output "$var1 * $var2 = $prod"

10. Replace the variables in text with their values in the following format:

	a. "var1" / "var2" = "quo"
	write-host $var1 / $var2 = $quo
	#write-output "$var1 / $var2 = $quo"

