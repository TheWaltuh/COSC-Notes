1. Create an array containing a range with a random starting and stopping point. The starting point will be a random number from -10 through 0. The ending point will be a random number from 1 through 20
$ting = (Get-Random -Minimum -10 -Maximum 0) .. (Get-Random -Minimum 1 -Maximum 20)

2.Create a variable that contains the contents of the array in reverse
$rev = $ting | sort -Descending
