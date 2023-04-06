Practical Exercise: Arrays & Hash Tables

1. Create two empty hash tables with the following names: keys and values specified on PSN
   - employee1
   - employee2

$employee1 = [ordered] @{
First = "Mary"
Last  = "Hopper"
ID    = "001"
Job   = "Software Devloper"
}

$employee2 = [ordered] @{
First = "John"
Last  = "Williams"
ID    = "002"
Job   = "Web Devloper"
}

$employee1.Username = "mhopper001"

$employee2.Username = "jwilliams002"

$employee1.Job = "Software Lead"

$employee3 = [ordered] @{
First = "Alex"
Last  = "Moran"
ID    = "003"
Job   = "Software Devloper"
Username = "amoran003"
}

$employee3.Status = "Entry Level"

$employee2.Status = "Intermediate"

$employee1.Status = "Management"
