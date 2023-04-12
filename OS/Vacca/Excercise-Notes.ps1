#Windows_PowerShell_CimClasses1 

#PowerShell doesn't have a native cmdlet that will give you processor information (such as get-processor or get-cpu). Knowing this information might be necessary. What command would give you information about the system's processor?
#Flag is the full command

get-cimclass | where-object -Property CimClassName -like *processor*    #useful to search cimclasses

get-ciminstance -ClassName cim_processor

#Windows_PowerShell_Logic2

#What PowerShell command will allow for counting lines in a file, averaging numbers, and summing numbers?

measure-object

#Windows_PowerShell_Regex_1

#What PowerShell command searches for text patterns in a string?

select-string               #-pattern option to specify what to search for

