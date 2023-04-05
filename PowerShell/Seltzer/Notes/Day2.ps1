###Comands

###Script Block
$myblock = { Get-service | format-table name, status }  #gets list of services and outputs to a table showing name and status
& $myblock                                              #how you run a scrip block
                                                        #everytime called it runs again, so goes through the commands inside again
 
$<script block name> = { <commands to be in block> }    #basic syntax
