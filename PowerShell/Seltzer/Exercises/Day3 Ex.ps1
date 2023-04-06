Practical Exercise: Create Functions

1. Write a function that returns the Ordinal date of the current date.
function Get-OriginalDate {
    $var = Get-Date
    $var
}

2. Create a function that takes a number(n) as an argument and returns the square(n^2) of the number.
function Square-N {
    param(
        [Parameter(Mandatory=$true, HelpMessage='Enter a value top be squared')]
        $n
    )
    $fin= (([int]$n)*([int]$n))
    $fin
}

3. Create a function that takes three (3) arguments and returns the product of the arguments.
function 3prod {
    $a = Read-Host "Please Enter a first Number"
    $a = ([int]$a)

    $b = Read-Host "Please Enter a Second Number"
    $b = ([int]$b)

    $c = Read-Host "Please Enter a third Number"
    $c = ([int]$c)

    $prod = $a * $b * $c
    $prod
}

Practical Exercise: Function Parameters

1. Create a function that takes two(2) integer values, $a and $b, that are the lengths of two(2) legs of a right triangle and returns the length of the hypotenuse.
Function pythag {
    $a = Read-Host "Enter the first side length"
    $a = ([int]$a)

    $b = Read-Host "Enter the length of the second leg"
    $b = ([int]$b)

    $a = ($a * $a)
    $b = ($b * $b)
    $c = ($a + $b)

    $ret = ([Math]::Sqrt($c))
    Write-Host "The final side length is $ret"

}

2. Create a function that takes two(2) values, $a and $b, as two(2) angles in degrees of a triangle. Return the value of the missing angle.
Function tri-shit {
    $a = Read-Host "Enter the first angle"
    $a = ([int]$a)

    $b = Read-Host "Enter the second angle"
    $b = ([int]$b)

    $ret = 180 - ($a+$b)
    $ret

    Write-Host "The final side length is $ret"

}

3. Create a function that takes the following as mandatory parameters and returns the information in a hash table using the keys: first, last, age, and weight with the weight value converted to kilograms(kg) rounded to the nearest whole number
   - First Name
   - Last Name
   - Age
   - Weight in pounds(lbs)
   
Function personal {
    param(
        [Parameter(Mandatory=$true, HelpMessage="Enter your first name")]
        $First_Name,
        [Parameter(Mandatory=$true, HelpMessage="Enter your Last name")]
        $Last_Name,
        [Parameter(Mandatory=$true, HelpMessage="Enter your Age")]
        $Your_Age,
        [Parameter(Mandatory=$true, HelpMessage="Enter your weight in lbs")]
        $Is_You_Tubby
    )
    $lbs = ([Float]$Is_You_Tubby)
    $kgs = $lbs / 2.2

    $data = [ordered] @{
    "First"      = $First_Name
    "Last"       = $Last_Name
    "Age"        = $Your_Age
    "Weight lbs" = $lbs
    "Weight KG"  = "{0:n2}" -f $kgs 
    }
    $data
}

Practical Exercise: Advanced Functions

1. Create an advanced function using Begin, Process, and End, that takes two(2) arguments. The first argument being an array of at least ten(10) integers and the second argument being a single integer. Search the array argument for every occurrence of the single integer argument then return the sum of all elements in the array excluding every occurrence of the single integer argument.

Function get-multisum($var1,$var2) {
Begin{
$sum = 0
}
Process{
ForEach ($i in $var1) {if ($i -ne $var2) {$sum = $sum + $i}}
}
End{
$sum
}
}

2. Create an advanced function using Begin, Process, End, that prompts the user to enter the names of three(3) U.S. States then returns the names of the states in the order of longest name to shortest name and the amount of characters in each name

Function Get-LongestName {
    param(
    [Parameter(Mandatory=$true)]
    $state1,
    [Parameter(Mandatory=$true)]
    $state2,
    [Parameter(Mandatory=$true)]
    $state3
    )
    Begin{
    Write-Output "Organized States by Order`n~~~~~~~~~~~~~~~~~~~~~~~~~"
    }
    Process{
    $a = ($state1 -replace '\s',"").Length
    $b = ($state2 -replace '\s',"").Length
    $c = ($state3 -replace '\s',"").Length
    $ret = ("$state1 : $a","$state2 : $b","$state3 : $c") | Sort-Object -Property Length -Descending
    }
    End{
    $ret
    }
}
